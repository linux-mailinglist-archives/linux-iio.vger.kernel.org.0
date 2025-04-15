Return-Path: <linux-iio+bounces-18139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863CEA8A3A9
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 18:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F323189F724
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120923496F;
	Tue, 15 Apr 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APlfLJVr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E5210F49;
	Tue, 15 Apr 2025 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733313; cv=none; b=hurlovsvGw545Q+7RuJtlPr2bqn98or00KWEAxEisOFzm3F7lqfZEnZnMDLQFXGXRiEA3jRRiiZZfXpfjqDNhUetBCdl5XdQ8vZFfNnuGa3FNbL0j0kSY2EFEgFfvowbgpaxIdQQzCHD2PfzGOOHKOvniZ2g7i4o9KPyfYdcb2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733313; c=relaxed/simple;
	bh=Epp6DWQBFHduWN1dTbfRFnc7iki98bhG5lprQjMcCx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHRC2VdkusJup3qE2t3y+40jIdqipybBMlEsQ26vIxt1ac1zaL7RQvMGdTEohRiYJnj0IYi3pAaQwwXhSGPSzEAbHWMIBHyGuYsNx+ePZhvMO1EqnIMANyK3pwcJT9hkUXDRyp8V8EEDDrhVWfNOkeB9Ie0xwGmrfI9UOo6iTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APlfLJVr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so4126780b3a.2;
        Tue, 15 Apr 2025 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744733311; x=1745338111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5KFN8rQwRDsAQ/Yg9O45rfWFUONIccvAncbkaEGxW0=;
        b=APlfLJVrB2ROLfHQYbAgUIHs73+5xQ1lVroSuuRYbcVyqi6b6y9r3+OzmCPAiTvoPC
         isD7FUv9LYRfuwq2SKZxzGbGjPt6sknEI/RHeSjQIRzydxNhl3oqwKBhFRC0kMbfGWa0
         Dd8nhUtoKODPwjcFq+0Qx5C6mzPIw7b3B4AWoXOth/Rb/B30COgDjXAguUit8TpyWszd
         Qi3HL5ar+ljXBvf97akHBHwubwGm+U8VPg090ceK5Bmdj2ojOtQxn2z6IJfQAaCIi4LI
         as7GnLhmwXFXrOeuqTdg5UkrVjja+MS/grhEnKgHEl2/rMVjd440uOfxVCC+jnEG9SXh
         K/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744733311; x=1745338111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5KFN8rQwRDsAQ/Yg9O45rfWFUONIccvAncbkaEGxW0=;
        b=xCugEiqIQZ+/+0RNshpeRZ9axmiktXLcfP7VxGuyWavdTd0XKx2eS8BT0QUNPADo3v
         X8iCr/f/Cez+rQBapXpHEXKldVMrSs6okoz/0NmA6DAzwTFTn2U2rfD62js0GwhLXl09
         uhpBqbBscAcdNUEGnZk/dyBBfE+84zgH+5WGcaK6RhxB3F8+3mm/V0bD1OQa4kvJtcn1
         7wNeU8e7Tj5BajbkD+byyjg83X556yB+noDZqFrs6QbWCb5ofrZIi6DOwDe+un6POZdw
         d90nGkshRReMji5NC+ewAGRF02cpLhrKFbiV1B25AKWDMuB+h6o2Z/gCGopcebQibEa0
         G7ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUHCSkv3HUnRAsRi460WJO2irZlxd91GrUeYiZG54XqsJRlVp6XFT3qps8x9SxaAu1940to30u+V9DLSAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqNiCdS2aM/kV1iwAWAVw65OBf/3WdaszTKPaTOSL0cbOGTJZ
	OtgYmyAR1U3yUPNCxhLq0uP45jiRIwIEWwfUN3+e9KVLWIqHjWxo
X-Gm-Gg: ASbGncuDNJwA25cvppbWJAYVWRW7Kjy+7pBP336hCitfxVKhSBEjxU/99D8+YUxDluJ
	qq4sgoYDmxI3G8V3uzZjdoImpSgzV/Izv1e3yqA6N9hlD6ysKJj+HTML/HkbHL9Dbm8tb7877MB
	XvpXZwX7FSC8Yec+hqSKPESg9lsSRQ4RL0MI6mC0nSjnJjs+sSLNhNt7C91kak2uCOcxkslCzSf
	ah6KatW1eYX362ajXtgaSZFnOqD+w91I82QTPwUehV5LIbtTmjrQ28LrlOq3W1EjBz81FLzS2WX
	dsjmwbVoVWuM5KZFPxC8XXMRP1AyFr+emhaCTUJTODL8F1E=
X-Google-Smtp-Source: AGHT+IH6y8NaDWBYMTdPKnRuy2ZV18VnXaLplADliZlMQ0z4zUxVD/TIhKxxpiEyVinXAg5jXp/ocA==
X-Received: by 2002:a05:6a00:1785:b0:736:55ec:ea8b with SMTP id d2e1a72fcca58-73c1fb5ee47mr21490b3a.24.1744733311052;
        Tue, 15 Apr 2025 09:08:31 -0700 (PDT)
Received: from localhost ([2804:30c:92d:f600:d5e4:543:c403:4767])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd2198be9sm8669243b3a.9.2025.04.15.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 09:08:30 -0700 (PDT)
Date: Tue, 15 Apr 2025 13:09:40 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
	jic23@kernel.org, Michael.Hennerich@analog.com, lars@metafoo.de
Subject: Re: [PATCH v7] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <Z_6ExCvQg8lH20z6@debian-BULLSEYE-live-builder-AMD64>
References: <20250414191453.10222-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414191453.10222-1-simeddon@gmail.com>

On 04/15, Siddharth Menon wrote:
> Use bitfield and bitmask macros to clearly specify AD9832 SPI
> command fields to make register write code more readable.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
...
>  v6->v7
>  - fix st->ctrl_x alignment
>  drivers/staging/iio/frequency/ad9832.c | 92 ++++++++++++++------------
>  1 file changed, 48 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
...
> -		st->data = cpu_to_be16((AD9832_CMD_SYNCSELSRC << CMD_SHIFT) |
> -					st->ctrl_ss);
> +		st->ctrl_ss &= ~AD9832_SELSRC;
> +		st->ctrl_ss |= FIELD_PREP(AD9832_SELSRC, val ? 0 : 1);
> +
> +		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
> +							st->ctrl_ss);
Oof getting Linux code style compliant tabs and spaces correctly can be tricky.
In sum, tabs should be size 8 and be actual tabs (not 8 blank characters).
Also, when we need to align code at some column that doesn't match 8 sized tabs
exactly, we start with tabs and go until the last tab that precedes the column
we want to align to, then we use spaces to go from that last tab until the
column we want to align to.

For this particular example, the opening parenthesis of FIELD_PREP is at column
50, so to align st->ctrl_ss with the arguments of FIELD_PREP on the preceding
line, we use 6 tabs and 2 spaces.

		st->data = cpu_to_be16(FIELD_PREP(AD9832_CMD_MSK, AD9832_CMD_SYNCSELSRC) |
						  st->ctrl_ss);

Setting tabs the right size depends on the code editor. For vim, the following
settings should ensure the correct tab size.
set tabstop=8
set shiftwidth=8
set softtabstop=0 
set noexpandtab

See Documentation/process/coding-style.rst for complete code style guidance.

Apply the same spacing to the other cases.

Regards,
Marcelo

