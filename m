Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89F7FC0BD
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 08:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfKNH2H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 02:28:07 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37326 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfKNH2H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 02:28:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id d5so5504427ljl.4
        for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2019 23:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7LYxoRWjL+BfmaiaO4yHLvcOVfFYwdP3LQ5KEb/iCqA=;
        b=lLpGY1EeeB58zg2ICzMYDxxayftxkWpkZ+rUfDQZA5b6THGhWNXCBkQge1iJGoQeh9
         vtnr8AYeWrtLMPMpa/Kvkww0aLrplf+bCXNU/7P43Kd08MkOlEp+qMnKN29LLWoyPeMh
         baMmylAzuNebdW3lvcqA+E+B/HCxQsNeD3hhOkvVOItK4QACAgbs2zbM0vjN+d8tdw00
         gARy5GU1LS6JY8UcAbfNdirN19lQVInax3tQw+2ECq8V6rtI9Dg2qJQXjdKRL/UsEA08
         twTMw6fXmY3xuWg7VwlhknSOWII+lz4LgfmIECOYwZ5MTRqMEqqoEYbb2MlaWEMP3qgf
         Objw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7LYxoRWjL+BfmaiaO4yHLvcOVfFYwdP3LQ5KEb/iCqA=;
        b=Hzd8HVCCToDmp9U2fnwPAg/mM0ZNmDrdvcr6v+fHKM3fN+3iR3iRAiakNq1uGSpO3U
         JMkRL+uykcfKc8gZ5q5IR1EJqi4xG5hV0YBKTZmI5DrauJJ/ezMb9uI1BPghiIuphHUi
         sGOiV86ASVlzoOW9gPz6SdU64wDEcq80v4VTxwPGNDXzUegzAXORyeyKXV0lOYf6zCxw
         l61Bb2XhMqxXqCI1aPsPr6/YGxv4mo+YkcN6v74msEKdUP4yPzPo6tX2LYY6X1P732mP
         fbmCuAPfQ8L+1QwHvXUOTmoYRdEL/XgM0IOOtbUNNwdvzBQKeppjvFNqFu73GY+BpC/T
         2M3w==
X-Gm-Message-State: APjAAAVkNoTEhI7iwNbZp5xdTjw2Au0VmdHJ5MjPAExDiToY6tWfSXi9
        P5LtMPo0VwmAJ0Lt26bdQvaN3Q==
X-Google-Smtp-Source: APXvYqxzzQQfIG+9jI5a1L+d+DpNn464CqTZoMFWJxPnSfZ1W7fCIUCgPFagE0pV7GCadiSt7dpX6w==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr2998566ljj.56.1573716484202;
        Wed, 13 Nov 2019 23:28:04 -0800 (PST)
Received: from localhost (h-93-159.A463.priv.bahnhof.se. [46.59.93.159])
        by smtp.gmail.com with ESMTPSA id u12sm1985300lje.1.2019.11.13.23.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 23:28:03 -0800 (PST)
Date:   Thu, 14 Nov 2019 08:28:03 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: Make enum relations more future proof
Message-ID: <20191114072803.GC26902@bigcity.dyn.berto.se>
References: <20191113100938.27604-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191113100938.27604-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Geert,

Looks good.

On 2019-11-13 11:09:38 +0100, Geert Uytterhoeven wrote:
> The relations between enum values and array indices values are currently
> not enforced by the code, which makes them fragile w.r.t. future
> changes.
> 
> Fix this by:
>   1. Using designated array initializers, to make sure array indices and
>      enums values match,
>   2. Linking max9611_csa_gain enum values to the corresponding
>      max9611_conf_ids enum values, as the latter is cast to the former
>      in max9611_read_csa_voltage().
> 
> No change in generated code.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/iio/adc/max9611.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index b0755f25356d700d..cb306ff1a5d6a0b2 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -114,22 +114,17 @@ enum max9611_conf_ids {
>   *		      where data shall be read from
>   */
>  static const unsigned int max9611_mux_conf[][2] = {
> -	/* CONF_SENSE_1x */
> -	{ MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
> -	/* CONF_SENSE_4x */
> -	{ MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
> -	/* CONF_SENSE_8x */
> -	{ MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
> -	/* CONF_IN_VOLT */
> -	{ MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
> -	/* CONF_TEMP */
> -	{ MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
> +	[CONF_SENSE_1x]	= { MAX9611_MUX_SENSE_1x, MAX9611_REG_CSA_DATA },
> +	[CONF_SENSE_4x]	= { MAX9611_MUX_SENSE_4x, MAX9611_REG_CSA_DATA },
> +	[CONF_SENSE_8x]	= { MAX9611_MUX_SENSE_8x, MAX9611_REG_CSA_DATA },
> +	[CONF_IN_VOLT]	= { MAX9611_INPUT_VOLT, MAX9611_REG_RS_DATA },
> +	[CONF_TEMP]	= { MAX9611_MUX_TEMP, MAX9611_REG_TEMP_DATA },
>  };
>  
>  enum max9611_csa_gain {
> -	CSA_GAIN_1x,
> -	CSA_GAIN_4x,
> -	CSA_GAIN_8x,
> +	CSA_GAIN_1x = CONF_SENSE_1x,
> +	CSA_GAIN_4x = CONF_SENSE_4x,
> +	CSA_GAIN_8x = CONF_SENSE_8x,
>  };
>  
>  enum max9611_csa_gain_params {
> @@ -147,18 +142,9 @@ enum max9611_csa_gain_params {
>   * value; use this structure to retrieve the correct LSB and offset values.
>   */
>  static const unsigned int max9611_gain_conf[][2] = {
> -	{ /* [0] CSA_GAIN_1x */
> -		MAX9611_CSA_1X_LSB_nV,
> -		MAX9611_CSA_1X_OFFS_RAW,
> -	},
> -	{ /* [1] CSA_GAIN_4x */
> -		MAX9611_CSA_4X_LSB_nV,
> -		MAX9611_CSA_4X_OFFS_RAW,
> -	},
> -	{ /* [2] CSA_GAIN_8x */
> -		MAX9611_CSA_8X_LSB_nV,
> -		MAX9611_CSA_8X_OFFS_RAW,
> -	},
> +	[CSA_GAIN_1x] = { MAX9611_CSA_1X_LSB_nV, MAX9611_CSA_1X_OFFS_RAW, },
> +	[CSA_GAIN_4x] = { MAX9611_CSA_4X_LSB_nV, MAX9611_CSA_4X_OFFS_RAW, },
> +	[CSA_GAIN_8x] = { MAX9611_CSA_8X_LSB_nV, MAX9611_CSA_8X_OFFS_RAW, },
>  };
>  
>  enum max9611_chan_addrs {
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
