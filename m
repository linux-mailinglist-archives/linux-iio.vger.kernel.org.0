Return-Path: <linux-iio+bounces-27901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6774D3909F
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 20:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97B330184DC
	for <lists+linux-iio@lfdr.de>; Sat, 17 Jan 2026 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402D2DF128;
	Sat, 17 Jan 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/gI5qRL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B02DCBF3
	for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768678980; cv=none; b=lbx8MSmRGX0AD3QbIgqBGo+yNdbIc5CQvxMEVZA7vKfy6T9axo9RZEcsu8M4vzj/wBBhPbGBdnOuBG/cK3o49o4wSaTiZLvK05RuoimRg0dw0In1UJPbMVTP9F0EchhHKCKSJ1vN1Ehn1GuH00UfbdCAw2UugJKM5NN1yVypTVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768678980; c=relaxed/simple;
	bh=kyADtZzJjqa9S3qeCD1Nc9zebIgMdiyTsz6JgRZYFxM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=A2jFCXfGragxRf1MFCJbziNl7xqMGOz0T1DDeVGnYwrGb6jXxnQy9Kv1i9uQlBa+29YoLGm0NeAn7+hMagPe0FvW2vFiNf3S3f6ueapVqWnZ73QWH5v5LjJYJyky/yV88IZlhCgukSjfrlXVtt6oBpNsv/hB9Wr280qmSnq/MBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/gI5qRL; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5636470c344so2303276e0c.2
        for <linux-iio@vger.kernel.org>; Sat, 17 Jan 2026 11:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768678978; x=1769283778; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jX+S0Sb3/TORvv49jMJHt7cR5imR7FosT/IXWBB8ZKA=;
        b=U/gI5qRLoIly0KT63JIlGIm+3DHlg4T+W/E0uiPXkgDD1oz6s3i+dpVigR/poR5Itr
         CW78Jo3Hsg0BW74k+rhtAG4acQqzOlY4oJhwkvwWDND4JMULqP779pSYf7XYRZgJCh/Q
         Nv1iIpZFzIRVdVWwjWq8dx/AlzgTL4FfV+7Mzd935hSdH7KG0Pouq1FEdxkDTT4Q+2G0
         KBK6XWrfOFF6N1NvBAyutfzWljyuVnY7HXBCqNNcg/WYveHlDApOqd7W8AWWheyJOB2r
         OQVKEc3S/BWjSKlaogVytsYHOF6+JChjB2z6sTkSxMlstFO5BcmLEUbQXNdTKW+GyGIL
         esaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768678978; x=1769283778;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jX+S0Sb3/TORvv49jMJHt7cR5imR7FosT/IXWBB8ZKA=;
        b=FiS3V1IN4mioMO7PyYr6ktxGoSWWZFzthTRSJmN5t4DH7bZ/4ctvSeMBxBLUy2KNbV
         dt/k3M/+/ErX8ZbRP3g++eKMis5pcyEkf9nXM98SfBJhXFHfvtEsCfPaZ4ZePWjOiVdj
         NktHvkF6UNsorRUs9KZ6AizwcF1yx18h+EG/KxXPMqrQBsJqVg8rDlbQMjMDRolCO/Uh
         zpZPUzNlbbuEtgibwV9FmvjZIRbLb/Cb5Xi+S9ql/RbzAuCeQKmKEjaLhN79yXrNyzRz
         7H2cJXctBdTZv2aM0a51n+/715jGufr5V2NpwlEBcUzZEl5mHquGvb0HoCUsmTM6VuuP
         3giQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK8T/P2JIqhLeBxUYsl03Q6gm/dA1hHPILw7iclyu4huKIG/WVTTmzLppLqECdG+i2JIWl+cV9fdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuF3too2Zmo7OO/vhr4W/csfnx48ihNdsTI0KpO4878LdCTnBf
	HsvbYS8+GEEhxCzIWrr3x9jZumYdjPGX8xNFQxEmdU97gpyETtOYxWop
X-Gm-Gg: AY/fxX7kPyw+mJtaRlTYvmd9CCtWoQcQuIlVTJBE4Ccs5CjPeW4t4gzEWw9Ie7LTUL3
	kKSU0pXf1VYjLX2Hyl4lXukVqbt1y19QuBD8r8cSAqHOTF8yNeNUhZZuBjhH5aX9YbZzDNUgY0E
	zkzogPkvzrS2j1/08SBrkjJhBrf3xlUZEwfS2waL8ZKlySq6748L6J3DrTvsaR8NVs2iXPsTRH2
	zL4htL8lLaoAdULiOaYuGZNvsTl+xmyWOuSVKcdMLyahwleOtLABaW+Ht6aoV6qaV0DlUuDRihk
	j++FNH6GT3i3rAOThb1wEGWHqW61AsydPQXJOxbPVknhtfF9j383bAKYiRr8BP4fV7EYY2itHES
	c/ngDeuNOgSZThUx25y+plcs2y2vcYMtScMGaIKGOKKVHH8GptpADMjDidjhXoGTal0JfNJVn/F
	lVGA==
X-Received: by 2002:a05:6122:1791:b0:557:ddc4:dea4 with SMTP id 71dfb90a1353d-563b5b8cfaamr2316062e0c.5.1768678978135;
        Sat, 17 Jan 2026 11:42:58 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b71226a0sm1568589e0c.20.2026.01.17.11.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jan 2026 11:42:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Jan 2026 14:42:54 -0500
Message-Id: <DFR4DC4NN16R.2365N6R1B6A9Z@gmail.com>
Subject: Re: [PATCH v3 0/7] iio: core: Introduce cleanup.h support for mode
 locks
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
 <20260116203353.59a2a00e@jic23-huawei>
In-Reply-To: <20260116203353.59a2a00e@jic23-huawei>

On Fri Jan 16, 2026 at 3:33 PM -05, Jonathan Cameron wrote:
> On Tue, 06 Jan 2026 03:06:55 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:
>
>> Hi,
>>=20
>> In a recent driver review discussion [1], Andy Shevchenko suggested we
>> add cleanup.h support for the lock API:
>>=20
>> 	iio_device_claim_{direct,buffer_mode}().
>>=20
>> Which would allow some nice code simplification in many places. Some
>> examples are given as patches, but the last two are the biggest
>> differences.
>>=20
>> In this version I dropped the RFC tag, as the general feeling is to go
>> through with this after some modifications. Main one is the addition of
>> IIO_DEV_ACQUIRE_{BUFFER,CLAIM}_MODE() wrappers to avoid drivers using
>> the guard classes directly. I also added comments on the forbidden ways
>> to use this API but I definitely still take suggestions on this.
>>=20
>> For now I dropped iio_device_claim_buffer_mode() rename, as this point
>> is still being discussed. My suggestion based on the RFC discussion is
>> to do it, but in a separate patch (using coccinelle) and while we're at
>> it rename the whole API like this:
>>=20
>> 	iio_dev_mode_lock()
>> 	iio_dev_mode_direct_trylock()
>> 	iio_dev_mode_buffer_trylock()
>> 	iio_dev_mode_unlock()
>
> I'm not a huge fan of flag days though this is entirely in direct mode
> so I can just do it at the start of a cycle.
>
> Anyhow, that's a job for another day where we can bikeshed the naming
> yet again.
>
> I do like unifying the unlock though.

I can send the patch, gather some feedback and then send a rebased v2 at
the start of the next cycle (or whenever seems best).

Should be pretty trivial, after I learn a bit about semantic patches
( famous last words? :) ).

If you feel up to it, I'm up to it.

>
> Patch 5 never made the list for some reason.
> https://lore.kernel.org/all/20260106-lock-impr-v3-0-1db909b192c0@gmail.co=
m/#r
>
> (I thought I'd accidentally deleted it!)

Yep, it seems it never reached. I'll make sure it does this time.

>
> Thanks
>
> Jonathan
>
>


--=20
Thanks,
 ~ Kurt


