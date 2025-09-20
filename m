Return-Path: <linux-iio+bounces-24324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED55FB8CA8C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1E3625D14
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17962F7AC4;
	Sat, 20 Sep 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3SQ+H65M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC12045AD
	for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379390; cv=none; b=YLw6avSZERbL0LwNYShG3CDXvYE7AzVcQZtu0b68CAXCfn6SnMl1A0doLpnslypxsW2Y5dNsMcmt9cGgdpHtIGwZY0UvsxGNkgq1UlHxTMauXGOEJo5qOEiF33qklI+pR0gtnjnppBTRFvW25OXe+L94lDjpxJ+ULeXV/0jjBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379390; c=relaxed/simple;
	bh=reGQ0DWfCnnIVp/Nxw5dBkwic445/96e5CXDstaYNKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMX93KQRUzNwLGT8hvESRw+JMaAQWS9wlKo9cTelvU7Xd0b/G59G9AzZBK49HfC5FzlurraYpaSKoWuuH4V76Yx2vMOSdYb9Q4WMW/D/TMUCd2iEF34R0U+Onwcc53jTEENElf6kxzmHqta2auC9Tjw040kc+PT0ZKfr4gzOiyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3SQ+H65M; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-746d7c469a8so2597478a34.3
        for <linux-iio@vger.kernel.org>; Sat, 20 Sep 2025 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758379387; x=1758984187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zr1FxzQeV23WAfXkGwnch/VhAJlzRpqociU7pEguSA=;
        b=3SQ+H65Mq7lmz1B5VG20x9Lq90j5XOP0m6A9igV9aIJktsX2S+XYfV8k40KiAfLXLI
         F4ynoVa80m9k1y+BFmkiBJDY++D1LOfVFsYh3SiDi2s09tmRoBKfgBoMC6JfNkaGNF6g
         zONNJcYhNQyRJjAz2SwfU+05xp9sLB3vkt6VNsYhrWP2jrdiotxv0kgfqXtz9iDTggUd
         wQgl5Hu1BHqzbKCvtsyEVkAY+zxaavsHVzrSRCKKOcw19LIHHJP5kqTH6EECU+ylMHAI
         5CNuh8Bi6BvwUP/cTwXTw5mtEd+v1sRXJxAbC12HV2/RjkkMVFh7Ef8GhLYhSjwLFk8A
         YDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758379387; x=1758984187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zr1FxzQeV23WAfXkGwnch/VhAJlzRpqociU7pEguSA=;
        b=wE+MIu+MkCwlJNUQiw/KzIPx2kIPVE10i4VGiaFUtMnd/wjPUYsn0wLeccuhJCyjP8
         Jmf+5m2bhprS0m+8wwiNiN/kU1knvfQqiV2NprXajfnuV6T/meTT3Qc5cu7rTU9LufOe
         NBysCVgPSk9OYBsEkKTmpSApCseT7voiQg6mXgSuwmVgg9VvO5vPSBODZ/AnqoV2mYLS
         yZJ/KGGAnp32J5LYbQs8E8oNHt+0ZMrUTE6pEM5Pkw5KQh6/9Pb7RRrjOHpGSzMwSXdk
         fBqxkDv4+lE+8Z85BTGNRLFRq3anqZGhsNgL/C6+jZ6auRZ0XaM9yBtLqH+0eqLPs71Z
         Z8qg==
X-Gm-Message-State: AOJu0YxqEtzUaYyafdFvSwY0eRtUBimmH8B4MOUXZ0sqRQ34gk5FXQVd
	68Cwp6Pgw6sO8j1UFfzFmeuq//mMaiIb1oIQ1121ZoWJus4/YsS91mCioUrlNCzDyleOVxE1fwG
	1g+858uE=
X-Gm-Gg: ASbGncvDuqJfhrqLhZw29mGcvBELh0J8oP1bpVgkiu5AEqRfv8DhDEyZSQku0UE0USd
	EdCpKmwQ7Z/yBHHYuSb1TgNbkDTV91W6UzvCLCQBxNNFMhpYAenuou55Uvb4knIXH3RWRbr2/0T
	ytW2N/Ur5OLbc0aEYLX0/Xg01nIsKLHx34LO/9aWH9f1ksHHZ+lWzLf58lOx1OjMVgeIsMLzp1n
	7g+tLhWpPFjYGYveBeZi6iruHo04wu7tWte45AM0AQ5GExjuVi8BVPsvU5hNh5TljY2wGZ4DJyQ
	VIfsoC9jQipJIMiFdiJXGafhoDYy0CaCIsifXe+0Q5NjHoK3WuNLXJUV2b6lJqfPvYO8Wy/MXRe
	fBhLcuhVQ5uJC2sv9FM4vNO0SO3x3SpBp0ChBCxhMzKruF2ofaG9WNSrQPfTC3/ZBH+1FAIoy2p
	E=
X-Google-Smtp-Source: AGHT+IFRMjIdQHCqLYdQqsM4bOgBkQvcyRd2wt9TOxoiyYemPs4kzShqexKQOBSerVYHshLpIqXW1Q==
X-Received: by 2002:a05:6830:6606:b0:750:69c2:365f with SMTP id 46e09a7af769-76f6e58bc30mr4230967a34.4.1758379387269;
        Sat, 20 Sep 2025 07:43:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4? ([2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625dbca6014sm2701941eaf.25.2025.09.20.07.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 07:43:05 -0700 (PDT)
Message-ID: <7021b57f-bad0-425d-a7a1-3a613a408a42@baylibre.com>
Date: Sat, 20 Sep 2025 09:43:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] iio: adc: ad4030: Add SPI offload support
To: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com, Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Axel Haslam <ahaslam@baylibre.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <da55c0ed6fe895dc84e79c8b64e5923a4851e58f.1758214628.git.marcelo.schmitt@analog.com>
 <20250920104251.3f7dcbb2@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250920104251.3f7dcbb2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/25 4:42 AM, Jonathan Cameron wrote:
> On Thu, 18 Sep 2025 14:39:10 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 

...

> 
> Just one thing I noticed today.  If nothing else comes up I can fix that
> up whilst applying.  However, this will benefit from review from others
> + the IIO tree is effectively closed for this cycle so we have lots of time
> to tidy up any remaining stuff.
> 
FYI, I have some comments on this patch I am working on but will be some
time next week before I send it since I would also like to actually test
this since I have the hardware.


