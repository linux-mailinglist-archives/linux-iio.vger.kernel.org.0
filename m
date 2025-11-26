Return-Path: <linux-iio+bounces-26497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB652C8C155
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 22:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6724A35B14C
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1353191CE;
	Wed, 26 Nov 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deK42UFV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3803168E0
	for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193581; cv=none; b=eFcfoyHv5JZhTdz8vt/tu4DAkW5RmQQiqMumbnDaXCS/E9lGXyomrUq9I7lwQrjqbIK8CGBfbcbll6d9yeYWQdsePLtY22hzGcVBsU5qTjCcfoVBehIK5ZaTtdo3FSU01Xm85RzKo58uCq7fu1d3hm+be/7PWZokpHHNrtHKWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193581; c=relaxed/simple;
	bh=I7kTABh17B+X7hAiHSdAzCitGZIIkxhf0zZ+R9ntBis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkVavKGXTgXDWnJABIK3QqcKCafMT1KbNbcQIzEbY0eLErmEH5SyQ2eHS7Dvekid8zQpYtWODv8jPWdm2Smdgj793GzwBeT2VORc4ojZHMnOA6PaeV2ETp2El0+CUTaVSmlLX4pIEiP9vzMVsp8hL/u4gHFvpHofaccNqx8rHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deK42UFV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bdcae553883so222436a12.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Nov 2025 13:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764193580; x=1764798380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f57tZRRJS5mjymV3PZucbsZN/abWrtpPerQT/ngAjV0=;
        b=deK42UFVmBNjYbj/1nRWbJ6WfjLjB/5L6GLQ+x/mlHVMAHQoqp+DOSlo+4kCbw7JBC
         6edirdrh61mlCG23YFZ048iCaLiwjh1IB0iliY+sPPBlczHhziG1ljQzRooKRr9/b1E5
         /aKSzMXFJ0JA3aJ8ousnmeJC6h2CE8SlxoD9ZNkVU3ujxEIY7hbebxT1KB+iMeiaU5Ln
         gwqcfo+9AzENFTU2/CTmACXiJvICY0157vN5wzqkfjK/ypOp6t7YtzxLh0Y0Nn6MOdIQ
         YGgefsr3hW95+aycPKz68yGq3aY2La/Zsd5Zl7jw6EmPqMUh4sM9l+mxqtRv0q0rj+pQ
         Dskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764193580; x=1764798380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f57tZRRJS5mjymV3PZucbsZN/abWrtpPerQT/ngAjV0=;
        b=sBrZRteFNpSSAEXg6trF2a+TdwoB6HvxNN8O7UhP/plXTAIY2n3LYPbxEf/O+29DNH
         99p0/B0V75RjhJdbeFYtwZ+YU/TqADYPEJOr0JoCDvqzjvXPG5K/c1gWls0ntGchzvcH
         XlmVr0JyobAn8b5J1qJq5nZFto7NWnKc3WaqT4hCCCEr9baX7gppFf7U5oIBbecqBfyI
         2zRixA5ennhy/HEZ1m1/WuzplfW7J0XNq2QJ022PlPxnxOdNxUlvykZI+N8huL5mKIUn
         7XTgkVv2bC9KLmbtxhtmIv4IsdZuUzxz7woSzFqN3BTljcnYGZADPNIhMOMi21sIoOES
         Wx9A==
X-Forwarded-Encrypted: i=1; AJvYcCVZQlv6s/ulAaR/s4bArkxo5EstX3mF+USL2oB+uVIPPaBTuFn3jgnzYiJtQq3bJ5NZxEfBcQXFOG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/3DN45dmXXajp1Qt9+UQTjrnoJFeOMAdEmd6MhZpZ0j9WvbW
	Sa8wB4c/ccpq5wcE8NGAvJ/5HlTr9DboolMuB3dPSv0eCIips3x3Elfx
X-Gm-Gg: ASbGncvrvQRw6B5F3+ZPBMfZrz5axS94c8GtHStCkLDI3a7Ras7xFmhv9PiR57zAL41
	Au8BiMuqq4Ye7FKdT4Q5w0JoIVeZfQ+1ykwQLxmZlTDV4x8cMMgHW9Q7F8I2gMKjpwgDNwRgY1j
	p0kc9ZhJGHS6zZ7JcDNgHhsSzdUAiJokRbHa3GcH+Ot75E3ND8ODEymuJPa/ASjhR4Je9RTQpLt
	8mZDSC4ZXKcCMPgnuOIg70U6567PYciYznPchXct0jCSOWMYpjlate+mTm5jC0eKaRwLYb5Xcai
	6UDsG1CB/pNp8WSgwmfQQP+0DWqFCWxX37X6uK7+8uGI+i6GUB5rw40Vw9KMmdMRB7EFYd9oFwb
	dRQBYYYANj9N4nz3/lPg+MEr36C2OVdOjFzVf9cNMGmcXpp0xlnOq4y3nY0B7Fw42f88LK8P+nT
	EoGkHydLVmN7e3KDumOXKAQNmQXiSEygVsEIObOuirOg103xEEMIZ/hQ5GOTEknS2/TO0Ixz5na
	cVEfYuM6huQrsJzSoTRxD9v0aykI4rd3On0IE25qR0w7oT5Hm7TkliErUE=
X-Google-Smtp-Source: AGHT+IFiT7UGcw1tPnPYiUQGrk8MuQgSpyJW2/e07uVRpThZ0xVrIRonpL5cSB4TPRgqFHH7CEflDA==
X-Received: by 2002:a05:7301:2f8a:b0:2a4:53f2:339b with SMTP id 5a478bee46e88-2a719296992mr14614779eec.21.1764193579561;
        Wed, 26 Nov 2025 13:46:19 -0800 (PST)
Received: from localhost ([181.191.143.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a93c5562b2sm25011227eec.3.2025.11.26.13.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 13:46:19 -0800 (PST)
Date: Wed, 26 Nov 2025 18:46:18 -0300
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3] iio: isl29018.c: replace sprintf with safer
 alternatives
Message-ID: <aSd0Q7qCueXDSZtN@Lewboski.localdomain>
References: <20251126172432.5532-1-tomasborquez13@gmail.com>
 <20251126203240.13466-1-tomasborquez13@gmail.com>
 <aSdsc6jhQLHLVfkR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSdsc6jhQLHLVfkR@smile.fi.intel.com>

On Wed, Nov 26, 2025 at 11:09:07PM +0200, Andy Shevchenko wrote:
> This is a bit too long. Usually in the commit message the ~75 is a good
> threshold.
> 
...
> P.S. Do NOT resend if not asked so. Jonathan may amend this whilst applying.
> Also note, this most likely misses the v6.19-rc1, so we have plenty of time,
> no rush with it.
Ah I see, my bad, its my first patch so I'm still adjusting to the workflow.
Thanks for the feedback, will keep everything in mind!

Tomas

