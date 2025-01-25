Return-Path: <linux-iio+bounces-14584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7421A1C520
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 21:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516CD3A8BF6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jan 2025 20:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E6157A5A;
	Sat, 25 Jan 2025 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCADBLXE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943697082A;
	Sat, 25 Jan 2025 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737835738; cv=none; b=lf+kMePd9xE6rfo3bO0fXVwCbjyk3YLdVFSxQmLtj8DP0eaYyXJSMLob4+RRfwEy/rkpKFt4eSuIKf7NYTBZ4lgzjt2/5LPuyQER56zOr1FAEALfcLQqJUnOFbo5Qsfj/lnIz5CoAzKPS3DX79pgUqiDS53eBykTFSoAG1m9XDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737835738; c=relaxed/simple;
	bh=R0yDkOgJM+kTuTkXnngAFAwVepqZ24yMOkjckWeLrCQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=dh7sPwlFeJtMPxWKdvMCEkYLj+BodBjCl/NuW8F7Zh7RzrgvQvEfq3JfwR1kwMvL5e/jjC06+/Q4Ab5ClQKAD7PUqYgWnJqdu8ZQt1+wBxRKy+kGmw2rpxSR6R4wffoXD1wVr8dAlASha3AVbAMcYXFid8BkIajr6VSPShF4reE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCADBLXE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso2819383f8f.1;
        Sat, 25 Jan 2025 12:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737835735; x=1738440535; darn=vger.kernel.org;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0yDkOgJM+kTuTkXnngAFAwVepqZ24yMOkjckWeLrCQ=;
        b=QCADBLXEWQE+SDH4yB6Dox3OVcMg0jjv3ElTZcWDkMLBWRBf5uETLhtedm0BZ/vsZA
         qgJgAgvVpEhm7iJeJMSUloYgazwpPu6Hq5+IUMGCvOGSjS2coEypCc20hf48A2n3YHNi
         mzLEQK3CDpZfmCVKM6PeJe+VUCyYCCws3+lJ2D3z/grKUjzKhMw7psSPNR5Wq6sI5xaP
         H2u6YOevDlIU1XUnCCKeXASXMbig02TyI6WOc23c4A09hZbhdhrD+bi4NZdiE1pThDXn
         2D2SnYUFU2bj9Bd8HHpAxhfcHbs3g6ETnMS5j/mPWhqkSP7arnOwx2E6at1MKfA7FSnI
         NzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737835735; x=1738440535;
        h=in-reply-to:references:subject:from:to:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R0yDkOgJM+kTuTkXnngAFAwVepqZ24yMOkjckWeLrCQ=;
        b=A+/qmgsXT0y3Gp47vfRiSEyedztrTC4yQqk1kBXFNieU2tYbv24YxOj4viMgaTrxtw
         YUx1d8jOaO/tgxKy3cDUi4F8LIwiy9q27KbLONgX8hL7903FU+pt2Sp0eXzWQH+3/4yQ
         AWhksTY0C9ruXlPSwiMz+jGbt1/fN9hQfpv2zrOMg3gh+d+1qyO0QjgAmLJUyNIkmksv
         mZt4BlKx7rjVvoclhvJ/GUNFP2AAjJteCFtG1gDlHYx7x5uSx8PgbnDtcb6am3bZvUZ/
         PvSl8OQpAjGD3D2s7R8K1AD6kFSYS6gsiLMeQTcHpLudUuQyN6AlE7suBUMRZgBzhZ10
         Gz7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9aOFB4KoowCMByX0LTJ8SrEyEY4EajxIPAf9OlN9Eq8F63XWANNOL5+0CD8Ddk9meBLeMeA6ZIm2/C0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HaQVctBL8qhSWhHMWJBdROUma6HDZ1gDII13GCDZIAEPaWa4
	CE2Zarc8Ydm5jH+iM7UuM/Tby4umg16hCCFwfn6FNqMgWgqnjnjT
X-Gm-Gg: ASbGnctnhR4WyB4u0dsi0mHbda5FN5ECZz6iNVbbr+gBe3mniAZNH/HkXSSdUQZayAY
	AzljnEODd6RCGMtXLx0YU0ph5i7SsC4b8/Mnwt+QppmoWbX9SHzgt3kTxbhbCjUTyXJIBcc9qpj
	EfjS87h4azegobUziSAIuhGafkQiE8rWESl207rT5kKxLbU5XLg6JUZX9hT39+yYvM/0DMXUKqn
	Yv37BUoVtcPw9UmX5KGIVtylh8KxsuTIU1dYKDCdsiu9WVMDX5vPG48IYW93I43AL3gDtiWiWRU
	NfFcCvu/tlZNslBrK61zh8PsSzwhT1+X/JIHrkBYUyAO3o0oZvAET5QTSa8wqJ4iHVk1jDJOdap
	Iv2UailolyIAmRxqdx9Kisxms
X-Google-Smtp-Source: AGHT+IGFUQ4B1gE1Tc+/qXWJG+nJNTCbaQLFdt/0rvpDcOH4DZyKHjPYtF1rTM5+xlv2m7D/haVCwg==
X-Received: by 2002:a5d:52c7:0:b0:386:37f5:99e7 with SMTP id ffacd0b85a97d-38bf5674784mr26480583f8f.33.1737835734454;
        Sat, 25 Jan 2025 12:08:54 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-30ed-5dd1-b777-da06.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:30ed:5dd1:b777:da06])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1c35e1sm6334557f8f.82.2025.01.25.12.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 12:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jan 2025 21:08:51 +0100
Message-Id: <D7BFCPQPV9W0.1C7B7VU5Y4FCL@gmail.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
To: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Rishi Gupta"
 <gupt21@gmail.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2 3/4] iio: gts-helper: export iio_gts_get_total_gain()
X-Mailer: aerc 0.18.2
References: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
 <20250119-veml6030-scale-v2-3-6bfc4062a371@gmail.com>
 <9bdd3a1d-0eb3-4ef1-a6b8-f613de1eecb4@gmail.com>
In-Reply-To: <9bdd3a1d-0eb3-4ef1-a6b8-f613de1eecb4@gmail.com>

On Fri Jan 24, 2025 at 9:12 AM CET, Matti Vaittinen wrote:
> On 19/01/2025 19:32, Javier Carrasco wrote:
> > Export this function in preparation for the fix in veml6030.c, where th=
e
> > total gain can be used to ease the calculation of the processed value o=
f
> > the IIO_LIGHT channel compared to acquiring the scale in NANO.
> >
> > Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>
> Hi Javier,
>
> This is fine but could you please go the extra mile and add a doc to the
> function? I'd like to have kerneldoc for all exported functions.
>

Hi Matti,

Sure, I will add that for v3.

Thanks for your feedback and best regards,
Javier Carrasco

