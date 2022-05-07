Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BA651E7B5
	for <lists+linux-iio@lfdr.de>; Sat,  7 May 2022 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381833AbiEGORY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 May 2022 10:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380867AbiEGORX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 May 2022 10:17:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AED74889C
        for <linux-iio@vger.kernel.org>; Sat,  7 May 2022 07:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C06B9B80818
        for <linux-iio@vger.kernel.org>; Sat,  7 May 2022 14:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C04C385A6;
        Sat,  7 May 2022 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651932813;
        bh=xGCM4EkvW0N+9VG0YSwGAx8DQhs1jZ7KEp+WkrURobs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f2CRj/h7vtYg0eTuuPH3EkPhoYHmbp5VKr2VI5wuF0ZyRUD/luuf08Zjy1iJgjM5y
         iijC6FmXtKuiI0oKy6h8DG+i2UJRzzanZ14Ebjj23nT1csqtAiVXThzfmiE6FWjCqR
         FXUuVOHM3Z3uvZgDpDMqYJgnkB2L+bRhUigPljisHEuPz/656ttWkw+5MlnKm+VV6Q
         tqkYHoK8OIpn3D6cmlobuFy2VS3aNlMSBIbJHxLrygSEGMJeOdy1Ddlr6q3IvXxtB6
         elQj7X3E9OZSmgaIm5IoMH2oJ6+4rAIILc2w9B3TD6XB/FIynHgV+izsTYMy1hlnX2
         THvIvA4nP593A==
Date:   Sat, 7 May 2022 15:22:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: axp288: Override TS pin bias current for some
 models
Message-ID: <20220507152201.6f0af4eb@jic23-huawei>
In-Reply-To: <20220506095040.21008-1-hdegoede@redhat.com>
References: <20220506095040.21008-1-hdegoede@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  6 May 2022 11:50:40 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Since commit 9bcf15f75cac ("iio: adc: axp288: Fix TS-pin handling") we
> preserve the bias current set by the firmware at boot. This fixes issues
> we were seeing on various models.
>=20
> Some models like the Nuvision Solo 10 Draw tablet actually need the
> old hardcoded 80=C5=B3A bias current for battery temperature monitoring
> to work properly.
>=20
> Add a quirk entry for the Nuvision Solo 10 Draw to the DMI quirk table
> to restore setting the bias current to 80=C5=B3A on this model.
>=20
> Fixes: 9bcf15f75cac ("iio: adc: axp288: Fix TS-pin handling")
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D215882
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/axp288_adc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index a4b8be5b8f88..580361bd9849 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -196,6 +196,14 @@ static const struct dmi_system_id axp288_adc_ts_bias=
_override[] =3D {
>  		},
>  		.driver_data =3D (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
>  	},
> +	{
> +		/* Nuvision Solo 10 Draw */
> +		.matches =3D {
> +		  DMI_MATCH(DMI_SYS_VENDOR, "TMAX"),
> +		  DMI_MATCH(DMI_PRODUCT_NAME, "TM101W610L"),
> +		},
> +		.driver_data =3D (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
> +	},
>  	{}
>  };
> =20

