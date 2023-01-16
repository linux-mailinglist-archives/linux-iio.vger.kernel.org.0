Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6190C66CDCF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 18:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjAPRm3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 12:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjAPRmL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 12:42:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9544193C7
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 09:19:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C1E8B8107A
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 17:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A253C433D2;
        Mon, 16 Jan 2023 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673889541;
        bh=rsqxvNwt1ZHG18NW2V4BZ4H/y74zFmRnPPCXavz8jyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kd2TaEuJaLVIryqdOh/Q5QFsF813I8oHUQvypx8YSgcNFTEXuOUYStCJitfNadezY
         nYuWoHNoK5rQ/cOAqkHwfT7LOh5VAssxzHxJmxrPBVauXZac9WhcpRBg4ngFsShZUJ
         4gLdsUN3MOEqXHZSg1qfgeckgy6LtqdLtC1LGUwkfgTv+4IbKJ9dYbBn4fCIwf4lX1
         z/n3roRq/tauZL1qm1XYnKYuk6JrYHyVvPTQMsUwODXTZ1MwM6UilCUlVKg5lRs4DG
         u/cI6ZgxzTEXo0mFdJqS4/dA6EwNdRMtAkzbZcA4+MjD6xTwUOQ8aJ14lBi+tQWsh+
         FVsBc8leCEfjw==
Date:   Mon, 16 Jan 2023 17:32:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     andriy.shechenko@saunalahti.fi
Cc:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v3 3/3] iio: light: vcnl4000: Add interrupt support for
 vcnl4040
Message-ID: <20230116173240.67045474@jic23-huawei>
In-Reply-To: <Y8Q5+9WogoIeFMmX@surfacebook>
References: <20230110134323.543123-1-marten.lindahl@axis.com>
        <20230110134323.543123-4-marten.lindahl@axis.com>
        <Y8Q5+9WogoIeFMmX@surfacebook>
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

On Sun, 15 Jan 2023 19:38:03 +0200
andriy.shechenko@saunalahti.fi wrote:

> Tue, Jan 10, 2023 at 02:43:23PM +0100, M=C3=A5rten Lindahl kirjoitti:
> > Add support to configure proximity sensor interrupts and threshold
> > limits for vcnl4040. If an interrupt is detected an event will be
> > pushed to the event interface. =20
>=20
> ...
>=20
> > +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	val =3D (u16)ret; =20
>=20
> Why do you need casting?
>=20

Looks like these need a little more time.
Dropped from my tree for now.

Jonathan
