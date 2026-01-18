Return-Path: <linux-iio+bounces-27930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F8D39997
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 20:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85B7D300182E
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jan 2026 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1B23EA81;
	Sun, 18 Jan 2026 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f2dyVcNs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D839FCE
	for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768765565; cv=none; b=Yr0ydPZVS9LwCj7cpI9r97119hbu6rjtpMdRScZcCYDOWrALu1otOt35MBvuoL5xVIOvlhc1zXCSY4j0QZ/qWcD6XFp8aYMj0ar6X+FcWPfD/AENAc1r1pzoev5dOjPWJb6uKCgUOsBVrFGX/o1WfgJd7PwdKyFPVDQG8AlSgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768765565; c=relaxed/simple;
	bh=ujVW9sDXaLFzKGnXAu5cGf0WUh1AesvBPA/OQIeUeOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VDxdUd5IY8POxPe1S2qxl/nH2nmBddWdC2BQw4DHlEvfFfQt9gBhImBdmcUQsH4FG1krp7jFHUOArr+PFfPUDBKN+cJbhimvm4R1v0y1wNtU5JCj6EAGVtxv8YR/MNchwJAIrbpOcnsbzRtbceCf79jhIOtlvcusUFTSZfsPExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f2dyVcNs; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7cfd9b898cdso2033497a34.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Jan 2026 11:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768765562; x=1769370362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/oeD3cM08837+cCP+kX3EVzrbL+4w4ZA6F2chjridk=;
        b=f2dyVcNsFu/XRreUBCRYUe2g+JUXtgfOyM95N7z9N/Azk4J2HrOUx3xDp8CD+tZNbU
         YElYysyQrcoqrk5Y1B4kgamHHy49IkuEQUMBuSdzBHrzcCrNdfBRGPF+zH/RAH16GrDC
         SJA/PXlr8izjDlpyZM4npN/gp/fZFSKkjXv/QjL/ZfOjZNdyHrLNDv4vyUUoTQpBepVh
         I9TYEtRJDRus/EZAGg8TYkvYHHnd6zReD2EM6Z/IXMK4Ys2nR35GmSzyQvHUmZgioLqy
         9NGADc3+sMNibgXVbbkyUtVzhxkk1h0AKYj3reYaQ4pS8E97iDzTkbmKtl5hs1ans9Km
         jMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768765562; x=1769370362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/oeD3cM08837+cCP+kX3EVzrbL+4w4ZA6F2chjridk=;
        b=KFiDM6WzsQHzY71iPjP7isGS9ULgco4rvRA1dOjNaBnlV7mSHpz5hYsgCLytSN6Kbp
         O2zGhq/QSfg/kF8S1pzlraPuf6xlcYeCz49c2BMPmYWIdj0XjQKad83ZpD7xa4MFn7EO
         GkkyE2zjbrddzjIXOl6Rq7YrJNsvFkmvrgr54tq3IlEKwWUHQdX+/VtBoOFPivbSxPO+
         ke5ed774fhfoUk5nLTuVhjdssueyehLFBtRAj4P3aUYUsT0tYwyYcT1yHg4YMU18m7FF
         qduw8xpqiUSoS3Q3S190PuPVY61b4ZlwPZiwgXTkCzARzipW+XG4tWafe9hv97PSSuxi
         EaXw==
X-Forwarded-Encrypted: i=1; AJvYcCXlv9DJRuOvnLhzZ1EZnU+s9cUh19aiRUr6tcdyOGfg/IfTV2odvPOq6DXQwLPdhb0DUsrJq797ecg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvbNuCS4Psj1epBD79cUlS+jKeV0UTfkN1s7877UViBlg/EjUb
	JGm8YPPUAyDuJSJstWiHgDWJwDquR1rzvRIkiFRkUdbviyTiOdGJ2jOSEgpx06BczTE=
X-Gm-Gg: AY/fxX5iVGUpmkMMANEkQ+txWlWrTHZHcy4Xr0FEQHc70O/9p4PYX7+Md027oLlkVg3
	WqQ/C+h/kP+9lF++WDNX+niZdRSzihZYTxK+46OohFugVhbGLrgsUMWFAzwjZwzuwOVyYA1h8Vu
	Ifra+4l3uPVw4N4UWwoe60F/m95dnIPFau2ybQ4PK6lM4+pCkGv4igX5JZRoSflPLTqnFvFmx+b
	fw8G2+q+8Aho8oXcVmDju3TowyU+TnjxWVi2Il8AsoQ9bt9FO1fP95OhvEbGQ0DXytN4O1UzPDB
	BiOufJd9ohP8SidUfaGwAZSt1FNhfC/CcHh2iaWNv3G8ErpOGB1ehfZjSU5ErWfqJq9W+QXrId2
	pOVneVVy9y+mCi50muTfsRDlH0xjRT/e1KqRwBZgWLVuNDFXnWVywmEDhGg4FRk/OiaYifAzwTk
	+QaA6xwHfD+LwUYn7zJiBvz8xiK2B7JbEvglIDuLx23e1mMrPl4Efr2hlE3m1A7y0+yvftkUI=
X-Received: by 2002:a05:6830:4982:b0:7cb:125d:2a47 with SMTP id 46e09a7af769-7cfded3181amr5315130a34.1.1768765562478;
        Sun, 18 Jan 2026 11:46:02 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d542:af69:64b6:f7df? ([2600:8803:e7e4:500:d542:af69:64b6:f7df])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0e94b2sm5493635a34.7.2026.01.18.11.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 11:46:02 -0800 (PST)
Message-ID: <2d148091-9e40-41ee-95cb-544abcbf81be@baylibre.com>
Date: Sun, 18 Jan 2026 13:46:01 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/9] iio: ABI: Accurately describe
 in_distance_input
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, Jonathan.Cameron@huawei.com, nuno.sa@analog.com,
 andy@kernel.org
References: <cover.1768759292.git.marcelo.schmitt1@gmail.com>
 <b38d761e3d78d6121bd3f3de0908a156ad9ea277.1768759292.git.marcelo.schmitt1@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <b38d761e3d78d6121bd3f3de0908a156ad9ea277.1768759292.git.marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/26 12:20 PM, Marcelo Schmitt wrote:
> There is only one driver (drivers/iio/accel/mma9553.c) that declares a
> channel of type IIO_DISTANCE with an info_mask containing
> IIO_CHAN_INFO_PROCESSED. Though, mma9553.c provides distance in meters (as
> would be expected for the _input interface). Split in_distance_raw and
> in_distance_input ABI documentation to provide accurate description for the
> in_distance_input interface.
> 
> Fixes: 7cf78db585b1 ("iio: Add ABI documentation for illuminance raw and scale values in light")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> Added a fix tag though not sure it's needed/desired since it might not be worth
> to backport documentation?
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index aec39b8e3345..27251b65ea0e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1613,6 +1613,13 @@ Description:
>  		user). Units after application of scale are Joules.
>  
>  What:		/sys/.../iio:deviceX/in_distance_input
> +KernelVersion:	4.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute is used to read the measured distance (in meters)
> +		to an object or the distance covered by the user since the last
> +		reboot while activated.
> +
>  What:		/sys/.../iio:deviceX/in_distance_raw
>  KernelVersion:	4.0
>  Contact:	linux-iio@vger.kernel.org

I'm not sure it is worth splitting these up since the documentation is
just repeated except for the bit about scale. And it is common knowledge
that scale only applies to raw and not input.

Also, looks like raw and input are swapped. raw it the one with scale
so the sentence about scale should be with the raw attribute.

