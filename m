Return-Path: <linux-iio+bounces-4868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5FA8BEF37
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 23:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8711F25858
	for <lists+linux-iio@lfdr.de>; Tue,  7 May 2024 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017914B97F;
	Tue,  7 May 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TUCl5EAO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912018732F
	for <linux-iio@vger.kernel.org>; Tue,  7 May 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118630; cv=none; b=SkAs5NBvEy43x21/JpIpTgI3+cUB53Uh6UOdR2HL5CVwfenTtsHH26Os2PQM7LZdPj2p1MChX+azvO042PN4edKcc5QUDD+y97+BKzGFTTXTL6G7WdNhbZ4XACKv2lExc+oYZh+BOD7WniYc2KMNtbY3voxMW91Cvop8pDGbwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118630; c=relaxed/simple;
	bh=k/Fmvrw6ivn0OBCd4ejiX7EoMngluIBR++msmMA3UgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjVk3WDWL65lTtk/0iKshAq/YQvVLVgxEFwJXKR7Guw1PGL0oRYKqAtdC0CaUak+IP4Lti+qrcPITp4BR8n9tqeFqKzFt4UFRzgmtczVhNCFCSUPkyfW0y8qsPl5W+cRRyyG+CFWnl77i6Tdmw/6Bj1OD3BGXzI2O+PlrMcrBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TUCl5EAO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e0a0cc5e83so43462471fa.1
        for <linux-iio@vger.kernel.org>; Tue, 07 May 2024 14:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715118626; x=1715723426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMSxschXHdtUTx8EvCmPO+O38rQFayTg7ssUSx+D+vU=;
        b=TUCl5EAOA026flaLvWULeudqE6jmmrk2DuI240pb123z1iEst0JvuadvTwTmGwUNwi
         9alaNHBhswmf4qda5wvhg0Pok6KU/MHhDpcQGqivW/LxxQoxDASJE3xTMGMJ0TlXylGg
         Tet4OZ/aarvbSALDIb/nw+2MIbIIhn/OEn4NOQk/P4mNFH4VD2rI6+JiUxSZcEkg53uT
         BwIYKOLRJFF3bLJ7LGuIThQltLGm/Etm0ID0s6Up1CfPwdeGoCo9g+galzEvCPikLZQP
         5z/to1e6bfF6TQ46x9E8m5F0enzgTxdZJEWePPiHDyTvenK8HtfotWkOcDOaM73jQ7Vo
         4fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715118626; x=1715723426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMSxschXHdtUTx8EvCmPO+O38rQFayTg7ssUSx+D+vU=;
        b=nxl3th6KVWywNDSVPke+gb1lV+zC5S4B76LFY4EgvEUiXLmNLsDZ3mqdcIGLxC2YhR
         ODla+3NzPHNgDhm0wFT9M+Obbpdktnuo5a2+S5Xo3suI5V7e49mQsZcRZKwmG62CT7IE
         5G7hKlgeXfkQUSy/oadBeiw6+C7pClTFXvgCd4BCegVq8eBOBukolnQTcdjrsIAGy9RE
         0XJgfvLyXx6yBeNlnKY0wwmLXCskq7D98Ja/T4MjHlxv4rUe4DP/18ECCTLmpKcobc0/
         cRHPrN6y1BayJJ99R9hsrnbLmzLpI3tOpkD71CHAdViU4fV9wx5QlGThCh3yn5fHGQVl
         u2pw==
X-Gm-Message-State: AOJu0YxTxOwORx5H/LcWqGme+UiXGwjijKl5xRMCq6BZtOYOSCCph/5r
	1h1xvI0r9MKCaDPfnUYLWxCdb9CWFXZ8H4klti8/7uoybOckAr+wZw4eQSx7ayw7C32I/1kNTDr
	DTgcrBwNHo853CRcvBSShTitDAqhGtAXTtNpO3g==
X-Google-Smtp-Source: AGHT+IGOwOa0d0TEXVk3OQ0aiggq5u7OssM5CfXnJQjrPePulttdxTPz0CvOkrZOYFR7V5SU4Dpl4Gqjs/hwvbnTs6E=
X-Received: by 2002:a2e:924f:0:b0:2e2:b716:e67a with SMTP id
 38308e7fff4ca-2e447381ee0mr4092921fa.1.1715118625948; Tue, 07 May 2024
 14:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-dev-axi-adc-drp-v1-1-8d6a856f909e@analog.com>
In-Reply-To: <20240506-dev-axi-adc-drp-v1-1-8d6a856f909e@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 7 May 2024 16:50:15 -0500
Message-ID: <CAMknhBFLtf5KKoVaMPm18=8wNW_zvLq-iFt2R-zwcHuFQ-LUBQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: make sure DRP is locked on enable
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 9:50=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> We enabling the core, make sure DRP (Dynamic Reconfiguration Port)

s/We/When/

> is locked. Most of the designs don't really use it but we still get the
> lock bit set. So let's do it all the time so the code is generic.
>
> While at it add proper mutex guards as we should not be able to disable
> the core in the middle of enabling it. Also reduce the timeout time to 1
> microsecond as it seems to be enough and goes in line with what we have
> on the similar DAC core (adi-axi-dac).
>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.=
c
> index 0cf0d81358fd5..782d8813bb43b 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -42,6 +42,9 @@
>  #define ADI_AXI_ADC_REG_CTRL                   0x0044
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK   BIT(1)
>
> +#define AXI_ADC_DRP_STATUS                     0x0074

call it AXI_ADC_REG_DRP_STATUS for consistency?

> +#define   AXI_ADC_DRP_LOCKED                   BIT(17)
> +
>  /* ADC Channel controls */
>
>  #define ADI_AXI_REG_CHAN_CTRL(c)               (0x0400 + (c) * 0x40)

