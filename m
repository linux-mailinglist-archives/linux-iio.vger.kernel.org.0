Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB0866ACA1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jan 2023 17:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjANQdq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Jan 2023 11:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjANQdp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2023 11:33:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48641558B
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 08:33:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA599B80A07
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 16:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72507C433EF;
        Sat, 14 Jan 2023 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673714021;
        bh=jxI0WF1yJWk88jmBlHakvw8KLK3hrTuf9LWQ/GpQc+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BEM4JVnIu71Ck8HVMNWZXFH24piRabO68zDBWvNX0kS6zsiy7sVXrw85fIJybhGd9
         iGeF1AMKGRuZCrI9ZlwW41UqOlaDbhQsod7cHyyHKItmZ43KkfnHHY8WRwZoNgrlsK
         RELvpGSZiSnMw2MAu/v1lT7wDznhrhAdOnQGfdN5tqGR0uZmMQkY9ONBguE2746r3j
         7RBuvFXpEnn/l1U3t5TKSHfZTtgS+bb8bmohflqzJcEWC+ejsbZZ+X1HQcJW5Ya1tj
         Kyag3yR2+ZOv7H6KDjC4Gdo/5nyRrD6cEK5Wt4t/mvkmUZvFfmx8pnxRjtAaGzAgXJ
         ohZI6Cvq3SE5w==
Date:   Sat, 14 Jan 2023 16:47:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH v3 0/3] iio: light: vcnl4000: Add vcnl4040 interrupt
 support
Message-ID: <20230114164718.4a77bfdb@jic23-huawei>
In-Reply-To: <20230110134323.543123-1-marten.lindahl@axis.com>
References: <20230110134323.543123-1-marten.lindahl@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Jan 2023 14:43:20 +0100
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> Hi!
>=20
> I have made three patches to add support for proximity sensor
> interrupts with the vcnl4040 sensor.
>=20
> The first two patches are minor restructuring of the current setup for
> interrupts since the probe function hardcodes it for vcnl4010 only.
>=20
> The third patch adds support to configure proximity sensor interrupts
> and threshold limits for vcnl4040.
>=20
> Kind regards
> M=C3=A5rten Lindahl

Series applied to the togreg branch of iio.git. Initially pushed out as
testing so that the bots can take a poke at it before I make a mess
of Linux next if we missed something.

Thanks,

Jonathan

>=20
> Changes in v3:
>  - Only register iio_trigger when there is an irq_thread function
>=20
> Changes in v2:
>  - Make restructure of functions for interrupts and triggered buffer
>    in separate patch
>  - Add check for buffer_setup_ops
>  - Remove irq dependency for devm_iio_triggered_buffer_setup
>  - Change size of register variable and document it
>  - Use field definitions for read/write event_config
>=20
> M=C3=A5rten Lindahl (3):
>   iio: light: vcnl4000: Prepare for more generic setup
>   iio: light: vcnl4000: Make irq handling more generic
>   iio: light: vcnl4000: Add interrupt support for vcnl4040
>=20
>  drivers/iio/light/vcnl4000.c | 479 ++++++++++++++++++++++++-----------
>  1 file changed, 328 insertions(+), 151 deletions(-)
>=20

