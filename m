Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303A86767CB
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jan 2023 18:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjAURvR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Jan 2023 12:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAURvP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2023 12:51:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE9925E33
        for <linux-iio@vger.kernel.org>; Sat, 21 Jan 2023 09:51:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE09260B51
        for <linux-iio@vger.kernel.org>; Sat, 21 Jan 2023 17:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F36C433D2;
        Sat, 21 Jan 2023 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674323473;
        bh=sZWzoihZaiIXTZ/zU5SXV2Omaxo0XbptZhwDyheNltY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ctEugghFd63VmCkvnRBjq0IyppSyrFC1sNT7DjRNSkflmiR5iJSLwxE9fycMh/hr4
         UCcu5me5wMJXM1Wzn4B8E+g8Yi/BM2OmbvSI2yMwTdjr02gonblNcQ9/3WsmvEXgAk
         UaW90yyAGInTExfWQbPhqVlBRuKXnI03PNtfPLXVoiWOwQucJAe2GodzpKrPCoVDDL
         OQTL7k0zGQNfVUlwIdZDaT831CxwJ9l+t3LS4N9h99Q7YCkqossyJQYFF399SR2ZqY
         tIgm+0sCnXtkeFpUUpAKlPj2PE6gDOI8Q7y2zVyXH+7InYAE2Y5UV+ky300bAzd1vc
         GXeOyv9ZS7wVw==
Date:   Sat, 21 Jan 2023 18:04:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v5 0/3] iio: light: vcnl4000: Add vcnl4040 interrupt
 support
Message-ID: <20230121180458.43bd824e@jic23-huawei>
In-Reply-To: <Y8euwCLiKww7+AFe@smile.fi.intel.com>
References: <20230117190017.3789181-1-marten.lindahl@axis.com>
        <Y8euwCLiKww7+AFe@smile.fi.intel.com>
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

On Wed, 18 Jan 2023 10:33:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Jan 17, 2023 at 08:00:14PM +0100, M=C3=A5rten Lindahl wrote:
> > Hi!
> >=20
> > I have made three patches to add support for proximity sensor
> > interrupts with the vcnl4040 sensor.
> >=20
> > The first two patches are minor restructuring of the current setup for
> > interrupts since the probe function hardcodes it for vcnl4010 only.
> >=20
> > The third patch adds support to configure proximity sensor interrupts
> > and threshold limits for vcnl4040. =20
>=20
> The series looks good enough to me.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied.

Thanks,

Jonathan

>=20
> > Kind regards
> > M=C3=A5rten Lindahl
> >=20
> > Changes in v5:
> >  - Restore one more unnecessary line change
> >  - Fix indentation
> >  - Build reg value in a clearer way
> >=20
> > Changes in v4:
> >  - Restore unnecessary line changes
> >  - Remove unnecessary typecast
> >=20
> > Changes in v3:
> >  - Only register iio_trigger when there is an irq_thread function
> >=20
> > Changes in v2:
> >  - Make restructure of functions for interrupts and triggered buffer
> >    in separate patch
> >  - Add check for buffer_setup_ops
> >  - Remove irq dependency for devm_iio_triggered_buffer_setup
> >  - Change size of register variable and document it
> >  - Use field definitions for read/write event_config
> >=20
> > M=C3=A5rten Lindahl (3):
> >   iio: light: vcnl4000: Prepare for more generic setup
> >   iio: light: vcnl4000: Make irq handling more generic
> >   iio: light: vcnl4000: Add interrupt support for vcnl4040
> >=20
> >  drivers/iio/light/vcnl4000.c | 449 ++++++++++++++++++++++++-----------
> >  1 file changed, 311 insertions(+), 138 deletions(-)
> >=20
> > --=20
> > 2.30.2
> >  =20
>=20

