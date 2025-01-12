Return-Path: <linux-iio+bounces-14248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E150A0AAFB
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13BB1641FC
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B74E1BEF6D;
	Sun, 12 Jan 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWe2podS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211120DF4;
	Sun, 12 Jan 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699937; cv=none; b=cZ2SNR+oHBH0eueoBviYaLqXP6Du4vztYZz9FNyR2tWwXScsWEiG3cCd5xUMeQ2RmfA7GxA6ItC3Y50/FLcWuY4gQ+8wxsb+NB9QJtCoikYryCer7jsvzKr/ku8kJZ/eL7TiwfpcqAJj3dULTGnxeOG/Maf9QMDT/KvnQ/x26Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699937; c=relaxed/simple;
	bh=jPpGORFM6DLQsfgJohdnFBDUgiOLrJ46EWkWEEzNJ40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CaXtJmyN819U+NGYfUAxdbcJl8c45Upqi49u8q37uOQtuIPJai76/punLtAd1Q6BoNCMWJcp18OTUZA9yt6sOPqne0lKHGxECLur7DR2OV7ai8vhX7r/lRPfhRdsoGMLtqbBHl0ZPwmp9W4f2NXjEnYplctA6yn7qLZlrGof7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWe2podS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e3c47434eso3379182e87.3;
        Sun, 12 Jan 2025 08:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736699934; x=1737304734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ds2jyaTBI3B9tgp/razIWjdXXtbhaGZ8vh/IiAlVgko=;
        b=cWe2podSq52a9vi9iKVt+3sVLMZ48t+VwtKn0bPc3plQSHp4ctUUfX4fkwGIn4VKDS
         8Kie3sHrGG0hNJluBvO30qARaYRJ1IhVC0mzrMoXzTglSqgzCQcFlv1Nbg9nbp31FiKb
         Qb6cFnhGXuhXIX3x4nj+591COPPTpAq8d1k1VSoG7A6NlI7D4ZQxBZCMi8MGJoQQk4sl
         bO5XSwYdD55ktaagBH7XHXmTghBAXOL4LKbKhb7ybz98Z1kJv/Kb1aisAUV0vYyYEw7a
         jT2GBvJukMH0S4ZNeA4WMfouvHQYRj/SQ5K4n+HqcHd0BB88lyla+/w3MGfDlyO2p8db
         KBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736699934; x=1737304734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds2jyaTBI3B9tgp/razIWjdXXtbhaGZ8vh/IiAlVgko=;
        b=oJIah7hETsEU3130kZeNO/Wh0tMeNQKOOjDlxJyU9otXd4QgXyCf4ETs4DgcpUgpRm
         CS4BlzfM95nASz/YEx7fiKuS9gqDU/SuBaQhS/gHxAXLRfoiAkWuyqV4iDS4jOHnKBPr
         UwjvBrfzG4P4DRXw/b3g5C0ZhGk/w/nHBfNLePDt+TNhzzn+suBXUqds8Tl2uiagQ5Ad
         ZpOd5Nyf5Nj1tMbdhUH1gHDgCJEzjyuu7OV684dWQLpSsEg87rdhEqXxqjjkoVks6h6S
         VZl9L7y7y6K2EONHr2n1E0rHYLPhIatzrFYutK6kj9xh6Ag+1rJME0hBGlkU/L0qrzXL
         qM9A==
X-Forwarded-Encrypted: i=1; AJvYcCV4CXxPgzSY73AZvDMzNSADbhlwrbIpn3g91mYLB9tNFSgUrEBjIkA3X4LDK/w+tjC+OEsKnIea2l0t@vger.kernel.org, AJvYcCV4q0041uS0HqFRpWraGA0N8sTxT+bwOGZG/PN/wGEhculYPTEpXNleabn5mCxequ/Ydgul+jA5UtbN3yK5@vger.kernel.org, AJvYcCWj2VbEq2b5xnFI+6vdRU+tcKUefheBLWRuk7CElzaHvC2j50Tt6n9Lqy8AL1LOGaAmsI9oIOuvSmal@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUbwEszbhys/1fakE5RE9HSzRWBMqjjTwzqyFa6o9+slBHXaj
	0AbFoT2R+VYXWHsYr5+Y23dVg9ULVZeE6HJ0qnIH6m6kWVx4EmpvfEJzka3ydUrE6w==
X-Gm-Gg: ASbGncsFYwXDU6WhCUH2FDhX7IQQLo9oSL+Q2hJ0b7pgph6Fk17WOq9X4goj1Xg9fZx
	AtI492L9L93OyfReQxdYfEc6WJDNo4PlBMDENvUYbnCuPo9zOuaf6WrUCrgLG+SbtCpe5IM40hc
	BewKfNpQoiOm9nMWeFHm6XXlrcpb2KhmAf5fI71I/E8qj3vm976/sgl0iT9Wjm8jgUbq4/VW+tu
	buRwUGkn+2VwW+pgsp7C9WBibcI+/k7H2/HNYj3z+pcjn162ruMuE0ig60dIpOC5Q==
X-Google-Smtp-Source: AGHT+IGo0aM5LCtEa90lCe66FeXky8murQpb0RO1LekxgSviijCpb5SaMTYFb63BR0dtQcEDjc14EQ==
X-Received: by 2002:a05:6512:318d:b0:542:8cbb:b204 with SMTP id 2adb3069b0e04-5428cbbb7d3mr4312014e87.21.1736699933877;
        Sun, 12 Jan 2025 08:38:53 -0800 (PST)
Received: from [192.168.1.78] ([45.136.247.92])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5429941669bsm409196e87.7.2025.01.12.08.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 08:38:53 -0800 (PST)
Message-ID: <5210adc6-eb1b-4797-a2f1-0368cc44c392@gmail.com>
Date: Sun, 12 Jan 2025 19:38:51 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] iio: accel: mc3230: add OF match table
To: Jonathan Cameron <jic23@kernel.org>,
 Vasiliy Doylov via B4 Relay <devnull+nekodevelopper.gmail.com@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250112-mainlining-mc3510c-v3-0-9ee6520ab69d@gmail.com>
 <20250112-mainlining-mc3510c-v3-3-9ee6520ab69d@gmail.com>
 <20250112162917.6f0cfa9f@jic23-huawei>
Content-Language: en-US
From: Vasiliy Doylov <nekodevelopper@gmail.com>
In-Reply-To: <20250112162917.6f0cfa9f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/12/25 7:29 PM, Jonathan Cameron wrote:
> Are you sure that didn't previously work?  I thought there were
> fallbacks that would make it use the driver name if nothing else matched.

It works if I modprobe module, but module doesn't loading automatically 
on boot like other modules.

With OF match it loads automatically during boot, without i need to call 
modprobe explicitly


