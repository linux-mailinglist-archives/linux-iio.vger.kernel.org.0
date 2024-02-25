Return-Path: <linux-iio+bounces-3070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F5D862CE7
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 21:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4871C21403
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 20:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC018E27;
	Sun, 25 Feb 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vduig1bT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0D21802E
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894003; cv=none; b=b8Wnf2brcYuluuDLNHqqFhN3+Pi4hMbpUKZlil1a7hYqQehGxIn2dbsK5hszzwDv4+ftXQgy0NscL2TqpisCOUgmuoymkRmge+Iq5XmgMU8XxbuDdCQNtgqwP4lrDbW2LDhjdweaPcKrQGoKg/F+tcGdeE5Mzylxc+7h5loTZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894003; c=relaxed/simple;
	bh=SrPQRCzhMvMmii9hQdPXD1YvNqRI54qycQwonRLO1ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2UiSKwzPwNiYDz1tcThRhawqA3a3J7BOuYDHUoJUZyTaQdgoe2afFxrWOcq1FchFGCsHhO/KvEP0oC4xPOf2RtzLRkmHcUWDa+ezTASzcNoegDs0aXJcyYLnZTLBoe6GoPMvqKJr+Rz2zzIxRnvz1zi/adlEnXTRNZk+cfaMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vduig1bT; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1a2f7e302so104129b6e.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 12:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708894001; x=1709498801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jaoEWYXtOjOULbW2yMrOmnPYIPrfPlzxVubLNRsgJlQ=;
        b=Vduig1bTlKQbu0yvrCM/lHROy/o0ypR163cnclNvudv3dUoUjENn0cFSdPIeQm89s8
         q4btaB2uktWptukeVFh/71G45Z1czfj/K3/XagmBfqv/sWCbG+uWbv7xzGv2vxxJWsq0
         J9+eXFOoWaer0ppit8cWeRTwY25TQ7qDS73DvvWtSMx6wLWzEq3KI5Ci3x85MbrZO3fo
         svQ2x81PE5dKpA+XFlXONBlVrq8JWLynaA9C1/TQFa5ZKqpufA8wA6U6INGM4Kr1qSOb
         w5HM9ksyVKdxyUZaO3RbhyWXWoTH8qtCuoB7f8eIJdH2FAd7SaHG3RBBavDT16+ClqIZ
         F6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708894001; x=1709498801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaoEWYXtOjOULbW2yMrOmnPYIPrfPlzxVubLNRsgJlQ=;
        b=Cr1TiQd4EH/CdWnbUhcLKa+wVg/b1ICRQ6pfzvNjY7AflN1re3kEoSc2dQbNUhLJXj
         C86w+51fPc2NeuUxIA7UNgqjiMIhmhIbLCupQEB/F+9IiDpuTeN1iQQGmYWPeccphyHO
         9UgPeTE7D6FTZYj0Eg51tohfhG5slvFFQzapgIShGVZSDbbc2Ix5UA17V6E2xwhln4Aa
         wkGB6XKsR73eoPAAbPjdMBacox3LqfcI/J+75f1XSxSSYRh8FuSP13cWUfFk4f41Hvwl
         HkcXSObKI93rYZuXAj5QGy3XAg50xYu58bWddA+0TqGVIPFuYf6Ocg99lUImzEoRRwke
         xA0g==
X-Forwarded-Encrypted: i=1; AJvYcCX0oQfMkDsy6jcwvqMJxKt2JN5nFQZRf2JfElnGrDRJWPVDXCzRhUhDbc8MsOBAvd9fnZaOitSmzbBtH7aBKgJrHMfPnEJ8D1GE
X-Gm-Message-State: AOJu0YxX/s4hPbVxK9mDbgnuLxgyiksj8cBjoe9/3rOa/0+pPU+RABvY
	+2uY1jK2Ew2HHUJ5L3/NOAZuPzJuSEczBgsHv28XEfJC1W/l91FU9S/tbSEOQItm41l6xa27Ae/
	iEYa6D4fOY6M3MYtbwbFrWUPlIqXviGoV+4YZRw==
X-Google-Smtp-Source: AGHT+IHiHD4DCI2MPVcMU8ZdLBW9A24hnVLA6ZCjQvJY+jivSwWXTU1+Dm3VJmojw/adwKuuhVJDjGQVaJJkaIHmpPw=
X-Received: by 2002:a05:6808:d49:b0:3c1:9caf:c0b2 with SMTP id
 w9-20020a0568080d4900b003c19cafc0b2mr3215443oik.7.1708894001601; Sun, 25 Feb
 2024 12:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225202744.60500-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240225202744.60500-1-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 25 Feb 2024 22:46:30 +0200
Message-ID: <CAA8EJppAKRiSoHi3icFymSQjP-TQrOF2LcMEnE=BmK+=nv330w@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: qcom-pm8xxx-xoadc: drop unused kerneldoc struct
 pm8xxx_chan_info member
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 22:27, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Drop description of non-existing 'struct pm8xxx_chan_info' member:
>
>   qcom-pm8xxx-xoadc.c:386: warning: Excess struct member 'scale_fn_type' description in 'pm8xxx_chan_info'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

