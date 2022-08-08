Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418A258C772
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbiHHLWw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242409AbiHHLWt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:22:49 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6949643D;
        Mon,  8 Aug 2022 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659957766; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WncN/J6jFWmOuUfW/r0Cy7asGiQzUA6y7QhuiAhEaDc=;
        b=go3y9ib6p4wlvAhqD+14udIU6ndNcNfw6Ei+gujiIZe2mDnjtCjzwBYhz3DCkW60MOWXwv
        tWWeWR1683vpLlcMa4Ygfaha8bDQUqFbOQ9gJWO/AZ/zRoSwVBQ4TdjYPdTBZNUqOaxY6r
        OhPbbWEtkIMqLLq4pZLiF59MhHq0XUI=
Date:   Mon, 08 Aug 2022 13:22:37 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/5] PM: core: Add EXPORT_NS_GPL_DEV_PM_OPS to avoid
 drivers rolling own.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Sean Nyekjaer <sean@geanix.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Message-Id: <PLNAGR.UBLC121G9UCD2@crapouillou.net>
In-Reply-To: <20220807192038.1039771-2-jic23@kernel.org>
References: <20220807192038.1039771-1-jic23@kernel.org>
        <20220807192038.1039771-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

If you can wait a day or two - I would like to submit my own version of=20
EXPORT_NS_GPL_DEV_PM_OPS, which should be more versatile than your=20
version.

Cheers,
-Paul


Le dim., ao=FBt 7 2022 at 20:20:34 +0100, Jonathan Cameron=20
<jic23@kernel.org> a =E9crit :
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> A driver wishing to export a struct dev_pm_ops with both suspend and
> runtime ops provided could use _EXPORT_DEV_PM_OPS() directly but
> that macro is not intended for use in drivers and requires non
> intuitive aspect such as passing "_gpl" as one parameter and the
> namespace as a string.  As such just provide a macro to cover
> the GPL and NS case in a fashion that is in line with similar macros.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/pm.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 871c9c49ec9d..18856e0d23ac 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -407,6 +407,11 @@ static __maybe_unused=20
> _DEFINE_DEV_PM_OPS(__static_##name, suspend_fn, \
>  #define EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn,=20
> ns)	\
>  	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, NULL, NULL, NULL,=20
> "_gpl", #ns)
>=20
> +#define EXPORT_NS_GPL_DEV_PM_OPS(name, suspend_fn, resume_fn,=20
> runtime_suspend_fn, \
> +			   runtime_resume_fn, idle_fn, ns) \
> +	_EXPORT_DEV_PM_OPS(name, suspend_fn, resume_fn, runtime_suspend_fn,=20
> \
> +			   runtime_resume_fn, idle_fn, "_gpl", #ns)
> +
>  /* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */
>  #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>  const struct dev_pm_ops __maybe_unused name =3D { \
> --
> 2.37.1
>=20


