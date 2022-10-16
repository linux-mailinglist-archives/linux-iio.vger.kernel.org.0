Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13976600172
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJPQlR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJPQlQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110AD32B96;
        Sun, 16 Oct 2022 09:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CCDB60C33;
        Sun, 16 Oct 2022 16:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A0C433C1;
        Sun, 16 Oct 2022 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938475;
        bh=t8ofXfKPglvkpGcnpXI37W717YDPlstC6EYBYH4PA1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hsUC7SeTWc0K2Kws4CZjjmrAMpPxS/wB3+76UgG2uKumQwD7M0H9MF8rM/K9XlGVv
         sZA3uV63nhu56nWZU1hbRy2n9uLb769DOFrVIzzf9eF1/YCL3Pcdx7Pcz+IRDzuLtl
         sCe4ei8G0Z4jpjposDtd43RRL5orLAJyprS5KOq1EVPtJ+M7JWezvvGB2oxjB06zmB
         Q6irutQgyiDsgv797aIJn11bYEmzRh0Fbo536hlPs3Lw7gpCo1l6IKs7rWTM+KYJwZ
         GKV7iqKKuA2p7zuXJlJTebLtmzY0vio0xdOfkSXz3pWXvlrL+3y2LPO7SLdorQzI7N
         hf7D1CmO1c+fA==
Date:   Sun, 16 Oct 2022 17:41:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 0/2] Synchronize PM runtime enable state with parent
Message-ID: <20221016174141.0abc281d@jic23-huawei>
In-Reply-To: <20220929144618.1086985-1-marten.lindahl@axis.com>
References: <20220929144618.1086985-1-marten.lindahl@axis.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Sep 2022 16:46:16 +0200
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> Hi!
>=20
> A device that creates a child character device with cdev_device_add by
> default creates a PM sysfs group with power attributes for userspace
> control. This means that the power attributes monitors the child device
> only and thus does not reflect the parent device PM runtime behavior.
>=20
> But as the PM runtime framework (rpm_suspend/rpm_resume) operates not
> only on a single device that has been enabled for runtime PM, but also
> on its parent, it should be possible to synchronize the child and the
> parent so that the power attribute monitoring reflects the child and
> the parent as one.
>=20
> As an example, if an i2c_client device registers an iio_device, the
> iio_device will create sysfs power/attribute nodes for userspace
> control. But if the dev_pm_ops with resume/suspend callbacks is
> attached to the struct i2c_driver.driver.pm, the PM runtime needs to be
> enabled for the i2c_client device and not for the child iio_device.
>=20
> In this case PM runtime can be enabled for the i2c_client device and
> suspend/resume callbacks will be triggered, but the child sysfs power
> attributes will be visible but marked as 'unsupported' and can not be
> used for control or monitoring. This can be confusing as the sysfs
> device node presents the i2c_client and the iio_device as one device.
>=20
> A solution to this is to enable runtime PM not only for the i2c_device
> but for the iio_device child also. As there already exists a link from
> the child to its parent and both are enabled, all sysfs
> control/monitoring now reflects both devices, which from a userspace
> perspective makes more sense.
>=20
> These patches [1] adds a function to the PM runtime framework to
> synchronize the PM runtime enable state of a device with its parent,
> and [2] applies it to an iio device, where the described issue exists.

Hi M=C3=A5rten,

This seems sensible to me. With hindsight we should have probably
disabled the pm interface for IIO devices. It's a fun question on=20
whether we could do so now without 'breaking' some user.  Obviously
the users wouldn't work today, for the reasons you point out, but
that doesn't mean some program isn't relying on the files being there.

Anyhow, I'm looking forward to input from others on this.

Jonathan


=20
>=20
> Kind regards
> M=C3=A5rten Lindahl
>=20
> M=C3=A5rten Lindahl (2):
>   PM: runtime: Synchronize PM runtime enable state with parent
>   iio: light: vcnl4000: Incorporate iio_device with PM runtime
>=20
>  drivers/base/power/runtime.c | 18 ++++++++++++++++++
>  drivers/iio/light/vcnl4000.c |  1 +
>  include/linux/pm_runtime.h   |  2 ++
>  3 files changed, 21 insertions(+)
>=20

