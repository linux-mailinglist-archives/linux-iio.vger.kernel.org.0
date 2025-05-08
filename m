Return-Path: <linux-iio+bounces-19275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95EAAF2EE
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 07:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CCF1BA6E95
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 05:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B11214222;
	Thu,  8 May 2025 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmVRqfjX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31D8472
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 05:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746682412; cv=none; b=VJMNaEyuQBxyMbF5Bdea4Ur0xzP8MC3khwH9YNqRFPrMG60EY2pmtbDr+ywg0+65Ej6Tw0EYwOf1TKYLcZnQ79fjzRvT5FC1vB9JL1H7VJKl/Lcxgs1KApiM9kwoXvhs0JPUPp0P04/koBSGVJif5eQiY8sHobuBADkGKCYnQc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746682412; c=relaxed/simple;
	bh=Fqqo8j3XNDG27zR/MgYwKAR1+y2IW7PicGS+L7O7LA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjiakPIEfCzAENXqg9T7jpmtW5nzdI45aFgeVWzVncl47eVx/CifjAHxQKT6roDmU96lmlrXEfbAblX+LJ5LJr383hzA+fJa9WhCYFZUjadw3WhkqvPlqiPkiKr8O+KZuh5CSxk9c5qsO2fyqauDiujGc/Md++GsRb/kEbc2nps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmVRqfjX; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7394945d37eso516225b3a.3
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 22:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746682410; x=1747287210; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OiX5O1Dk6K2gR1T2ckg4zzTM2vG3V6kssiJUUGwtVzM=;
        b=lmVRqfjX9ccXRGUz15CBnIohBeQgiFzczENYXKFgAK/AIRMBEmNNdttSDTXInf08Cg
         kFz8ARzlW4Olba+OiUfXZLKcF3eKc9tCpDe/B1doFG/fnFkxrfI31ZxBsH2HgZg1ikZH
         JI3LxjaSE18Vvr35rKOZ+WlKza7CsXyF1cMyrfDTyrwbSQmSakzxLt0qRwxHj3+G6Kek
         7hHXmjjM7pIsn4+RfBm6ee2kZH2WYXy0I1VunHYIkBFXgJ5s7s1mmb1Hf6GhpScly3Ix
         J1LyYhKcTTnv00ATDHxiBDWbQ28CCpVGOqXsS1QPTbfawTiDw+ktdsyPcI5Ux0largS4
         tTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746682410; x=1747287210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiX5O1Dk6K2gR1T2ckg4zzTM2vG3V6kssiJUUGwtVzM=;
        b=KGcfFPCelnW8gmvwzsS1s9+4DGl9y0MU7WUaV2LrQsxgZzhmlw1+aKguKN9/E+qL9h
         Nvn71msBcrAtzOi0Kh7LjpyiYNYJW1IJy5u6fKs8yaR9fvXFBlmHVWAShyaQXgW4zFxr
         dUcywyPf5NX+XHANdePHV2gZiYHt1WTvPETREO3y3MmYODnYJYx0DEAg5wVVNd5jevGG
         pMaUQdvzEJkZxz4f5JGFXvOyqoxYYW0eIrDlApqMpr8hA6DHd0iQ7KBJgYysKfqN0oXo
         CMp9dMm1lItKr5/YYujLwGzWUGa9+oqXOp7d7sI9eUTG0AycWN6doKv26tXcT/CiYkGj
         EGzg==
X-Forwarded-Encrypted: i=1; AJvYcCVUqUDzWQUj67s8iGabGG/KvMFjizzF5LLnwxFN3fSi6WImyHsTuzdS/tBYHmDlGDKzRmBZ1u9zDmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpqywCFUfmFhBfGNTHwoA9jT0G8ldFKNR1m/DhRCfomnt62R9
	thDDpzgpfiScy7nVkuaDbjuWvcnoBInh4djiHVTeMjB6cvXrSdkuR5dyz69V
X-Gm-Gg: ASbGncuYFBfXhgai8sL3QYWsSzBt08dOHXl3EpVSthp6zj8Pbc7njiJtbrRza0Gcxgo
	ZH2SAs4q1uYaShFYvzZ2R0DM1yJ2Jt3GqGA1Hrz+VRzq8sQETc/NaM11V34ahdprJ09lqgleFq/
	6kwFhpBdueuha1snp3Wm7WHm+YTtcFRM+I7dXJMICkmq7K+nL/qeZKSZUCFmPjqv6jSXs8SpkcV
	v9sLugS7+Eqxn5qGMxQ3MD5F6ulvXzQxXLAST+Jf3os3rsD6NQDW/n3x0OcqRcmP/Z8OuW2w9Dg
	eBPFi2S90VfTi+wCsJhDnVBY35fFoyVQGVrXcYnTKauO9n9Sbw==
X-Google-Smtp-Source: AGHT+IGKqK40c+jLGecsZgzNBcrWu07YJ58dJUy3eLs6RWTjSus5j0nohLseDPIZ7jror6yTtk+gvA==
X-Received: by 2002:a05:6a00:a88b:b0:740:6f86:a0e6 with SMTP id d2e1a72fcca58-7409cefc23bmr8255826b3a.6.1746682410218;
        Wed, 07 May 2025 22:33:30 -0700 (PDT)
Received: from localhost ([2804:30c:404b:a800:55e1:4221:1a82:c6cf])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74065720b51sm10867622b3a.35.2025.05.07.22.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 22:33:29 -0700 (PDT)
Date: Thu, 8 May 2025 02:34:49 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: =?iso-8859-1?Q?Oct=E1vio?= Carneiro <ocarneiro1@gmail.com>
Cc: marcelo.schmitt@analog.com, linux-iio@vger.kernel.org,
	fernandolimabusiness@gmail.com, eijiuchyama@usp.br
Subject: Re: [PATCH] iio: adc: ad4000: Add iio_device_claim_direct() to
 protect buffered captures
Message-ID: <aBxCefMBxEQww0xC@debian-BULLSEYE-live-builder-AMD64>
References: <20250507180046.8515-1-ocarneiro1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507180046.8515-1-ocarneiro1@gmail.com>

Hi, Fernando, Octávio, Lucas,

I think you forgot to run get_maintainer.pl to get all the expected recipients
for this patch. Also, even though the code seems to be syntactically correct,
the proposed changes are not suitable for the IIO driver. See comments inline.

On 05/07, Octávio Carneiro wrote:
> Add iio_device_claim_direct() to protect buffered captures. In
> ad4000_write_raw_get_fmt, data reads are protected by the
> function call to avoid possible errors caused by concurrent
> access.
> 
> Signed-off-by: Fernando Lima <fernandolimabusiness@gmail.com>
> Co-developed-by: Octávio Carneiro <ocarneiro1@gmail.com>
> Signed-off-by: Octávio Carneiro <ocarneiro1@gmail.com>
> Co-developed-by: Lucas Eiji <eijiuchyama@usp.br>
> Signed-off-by: Lucas Eiji <eijiuchyama@usp.br>
> ---
>  drivers/iio/adc/ad4000.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index 4fe8dee48..55ceee6e9 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c
> @@ -583,6 +583,9 @@ static int ad4000_write_raw_get_fmt(struct iio_dev *indio_dev,
>  {
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		iio_device_release_direct(indio_dev);
In the ad4000 driver, the main purpose of claiming IIO direct mode is to keep
the integrity of buffered data capture. Basically, we want to avoid changes of
device state properties and the issue of concurrent readings.
Note that under the hood, iio_device_claim_direct() acquires a mutex lock.
Also, it is good practice to protect only the critical paths and to not keep 
locks of access control mechanisms for longer than what's really needed.
Thus, we claim IIO direct mode at ad4000_read_raw() and at ad4000_write_raw(),
right before running ADC data or register access transfers.

So, the proposed addition is not needed and doesn't really follow best
programming practices.

>  		return IIO_VAL_INT_PLUS_NANO;
>  	default:
>  		return IIO_VAL_INT_PLUS_MICRO;

With best regards,
Marcelo

