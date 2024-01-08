Return-Path: <linux-iio+bounces-1506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37337827A7F
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F601F23BFF
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BD85645B;
	Mon,  8 Jan 2024 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FiNY4zh4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085C56458
	for <linux-iio@vger.kernel.org>; Mon,  8 Jan 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4b739b29686so1387899e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 08 Jan 2024 14:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704751779; x=1705356579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPwL0VIADWvObusNS4Aap9j3lSZsmdqtr+hhZskgl0M=;
        b=FiNY4zh45Wb22FNH7vlPypDwgurJvV3rZv+3rppt5QVdyBGK/f0W6W6VQHlykCwAxj
         TrlL0wWDdg3kI8flLQovZnVb95wzc8dZsGlKcj1pYnKyHXW9lyYC1qVxU4G5S6yCdjfz
         HKxPE+TJEysExZcVLG3nvdTgMxWAIbzuK0UW4dmkxpZVwid3HLXwWEbE90dZAVS5znmI
         sVwY35TIz6l0a/0EL6CLNdyrEzTqkBgVEe0l7zSAGpIt3f3g9xVctLtdbbtJah9Af4I7
         8+4WrNJV3/YDrkNjqi4VgSQQ2kx3XW0BXvUSuP0QhiUMq1I2GQaedB9+4AKshpNiVvQf
         bdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704751779; x=1705356579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPwL0VIADWvObusNS4Aap9j3lSZsmdqtr+hhZskgl0M=;
        b=O9hp6Mi3iLyibZ7MFh86TQPhCsT6a82RHc4ZCG+kKvrbB1lTqGP6T0NGKwsQ4FXfkh
         24R51r/SK69LYpJC/uNdi9RUU+LxH8ZwsIIvET3uPGWfXq6SgerUqbrsXSCn14vyctog
         E4brI4op57JR+0VHz11pIoj1jD6r/50amZ4TkkHAfmIszjf8JBdmHJ0/U1rUXhiuXmp+
         SMGlv3Wj2qCWvp8A6imxyKYUj1UQRoZBAdmTgfT4Uq1aGCxAScWA9hDlnb6xsNtmqx5+
         bCy186rVx0nnipBH7vJOHdr8AVQS4EVUA216qt+G/1UMnZPlKbhHfe3EKoSl87ZY85X5
         QRvw==
X-Gm-Message-State: AOJu0YzIdSmqYwU3ZCjhC+k6HXCNLhiX3JDKHE7VttHOx73R+7x0plU9
	vDz5UTsF01rF5KWPddFIPbTQDllozMa3Uw==
X-Google-Smtp-Source: AGHT+IE6hTwFu+QRXDhnPkTMqdy0XSYmsMHuM7fSO/yZXKcRDQzPFDoRFNo79VfhiJlWDzMOLsuoMw==
X-Received: by 2002:a05:6122:10e4:b0:4b6:c780:ac90 with SMTP id m4-20020a05612210e400b004b6c780ac90mr334731vko.0.1704751778736;
        Mon, 08 Jan 2024 14:09:38 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id em8-20020a056122380800b004b6d2b7109esm81131vkb.46.2024.01.08.14.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 14:08:07 -0800 (PST)
Date: Mon, 8 Jan 2024 22:07:09 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/10] counter: stm32-timer-cnt: add support for
 capture events
Message-ID: <ZZxyDbYC9oHNKcGF@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-11-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WiW47Lt2gdjHTFQC"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-11-fabrice.gasnier@foss.st.com>


--WiW47Lt2gdjHTFQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:57:26PM +0100, Fabrice Gasnier wrote:
> +	/*
> +	 * configure channel in input capture mode, map channel 1 on TI1, chann=
el2 on TI2...
> +	 * Select both edges / non-inverted to trigger a capture.
> +	 */

I suggest defining a new local variable 'cc' to point to stm32_cc[ch]. I
think that's make the code look nicer here to avoid all the array index
syntax every time you access stm32_cc[ch].

> +	if (enable) {
> +		/* first clear possibly latched capture flag upon enabling */
> +		regmap_read(priv->regmap, TIM_CCER, &ccer);
> +		if (!(ccer & stm32_cc[ch].ccer_bits)) {

Try regmap_test_bits() here instead of using regmap_read().

> +			sr =3D ~TIM_SR_CC_IF(ch);
> +			regmap_write(priv->regmap, TIM_SR, sr);

Eliminate 'sr' by regmap_write(priv->regmap, TIM_SR, ~TIM_SR_CC_IF(ch)).

> @@ -366,6 +460,12 @@ static int stm32_count_events_configure(struct count=
er_device *counter)
>  				regmap_write(priv->regmap, TIM_SR, (u32)~TIM_SR_UIF);
>  			dier |=3D TIM_DIER_UIE;
>  			break;
> +		case COUNTER_EVENT_CAPTURE:
> +			ret =3D stm32_count_capture_configure(counter, event_node->channel, t=
rue);
> +			if (ret)
> +				return ret;
> +			dier |=3D TIM_DIER_CC_IE(event_node->channel);

Ah, now I understand why the previous patch OR'd TIM_DIER_UIE to dier.
Apologies for the noise.

> @@ -374,6 +474,15 @@ static int stm32_count_events_configure(struct count=
er_device *counter)
> =20
>  	regmap_write(priv->regmap, TIM_DIER, dier);
> =20
> +	/* check for disabled capture events */
> +	for (i =3D 0 ; i < priv->nchannels; i++) {
> +		if (!(dier & TIM_DIER_CC_IE(i))) {
> +			ret =3D stm32_count_capture_configure(counter, i, false);
> +			if (ret)
> +				return ret;
> +		}

Would for_each_clear_bitrange() in linux/find.h work for this loop?

> @@ -504,7 +620,7 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void =
*ptr)
>  	 * Some status bits in SR don't match with the enable bits in DIER. Onl=
y take care of
>  	 * the possibly enabled bits in DIER (that matches in between SR and DI=
ER).
>  	 */
> -	dier &=3D TIM_DIER_UIE;
> +	dier &=3D (TIM_DIER_UIE | TIM_DIER_CC1IE | TIM_DIER_CC2IE | TIM_DIER_CC=
3IE | TIM_DIER_CC4IE);

Again, sorry for the noise on the previous patch; this makes sense now.

> @@ -515,6 +631,15 @@ static irqreturn_t stm32_timer_cnt_isr(int irq, void=
 *ptr)
>  		clr &=3D ~TIM_SR_UIF;
>  	}
> =20
> +	/* Check capture events */
> +	for (i =3D 0 ; i < priv->nchannels; i++) {
> +		if (sr & TIM_SR_CC_IF(i)) {

Would for_each_set_bitrange() in linux/find.h work for this loop?

> +			counter_push_event(counter, COUNTER_EVENT_CAPTURE, i);
> +			clr &=3D ~TIM_SR_CC_IF(i);

Perhaps u32p_replace_bits(&clr, 0, TIM_SR_CC_IF(i)) is clearer here.

> @@ -627,8 +752,11 @@ static int stm32_timer_cnt_probe(struct platform_dev=
ice *pdev)
>  		}
>  	} else {
>  		for (i =3D 0; i < priv->nr_irqs; i++) {
> -			/* Only take care of update IRQ for overflow events */
> -			if (i !=3D STM32_TIMERS_IRQ_UP)
> +			/*
> +			 * Only take care of update IRQ for overflow events, and cc for
> +			 * capture events.
> +			 */
> +			if (i !=3D STM32_TIMERS_IRQ_UP && i !=3D STM32_TIMERS_IRQ_CC)
>  				continue;

Okay, I see now why you have this check. This should be fine as it'll
makes adding support in the future for the other IRQs a less invasive
change.

William Breathitt Gray

--WiW47Lt2gdjHTFQC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZxyDQAKCRC1SFbKvhIj
Ky5wAP4gGBh3+vNrHgCFcl/2xnX9onULDns/GxDSAl/SYUHaxQD/UlBRNYjuTlpn
mQy4bZaGfms5hT09QoJcBuaniegpLQg=
=2KS6
-----END PGP SIGNATURE-----

--WiW47Lt2gdjHTFQC--

