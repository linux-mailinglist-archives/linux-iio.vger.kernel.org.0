Return-Path: <linux-iio+bounces-27390-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2DCE00EC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 19:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AC9B300BA1B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354D7325734;
	Sat, 27 Dec 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sPoaspVO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650B3A1E63
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766859239; cv=none; b=RHiwV/lVwSjWvgew7nGTUgpSQ+uiuAQC7TQfcswzXLMR0mPnpeVC6zkZw3nkfF5T2g9wHB+Az4lFK72jb+6UI/ltmDxt+iw09sQHWEba9OY7O7/bzETYbFcGx/hDcq0wIsHcIGvOenbrxQQV0IGzw9mIYAkorc6hkRsBpcO5KC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766859239; c=relaxed/simple;
	bh=4vuQrVLNaJGUWJWBNtmz4jC/+TxwI/W3PLlQhaXQly8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SSyyfbIZVSXlhFyyzwNLqlTJT7did/CM57TKA9RcibSr4B2vv+JTLEuI/R6XWaxT19GhpfMse+hKMzMIBOdeeUKuddMOfXRsOgTPVP6CxBcms2BatYyLgDMLoQfGMe12Ewm5Ua8+qAnokYq/erGf82IKbM5i503SNKjE+galyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sPoaspVO; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-450823a7776so5100326b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766859236; x=1767464036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/yiNmEm36TsWNfUH8F6Tvae1msGjni9hNs8R/sZzZE=;
        b=sPoaspVOQP9qEB5wM63rV+oTK3RBtY7+DCmWV4YL/4ekwezBR70maoOemOSWvNl2AU
         Y99bHJEd3Y2kq80n52OLbYFvg/CM44wL2XtKw/vnM6/fbmcKFASSoADLibxBSqhq6Ntp
         S6mSWC6xd4LSbVKFu9dYmTplM0luAp/5p3zRt/qhDNu2+tJkfJw9bGtXXPOvHcbRv7ax
         twGRx1nqXa9SQYcZ0sT6oj1GvNEPqDHTTiTSLCbAhn2X5aoW6zl+Rh5Aw89TF4ouLVu8
         1/QhowcIomuxRWkfrXHn95mMri3qt1J1kNeXFE/DMnChZEGzY4JgikDBNVHV0UQgnSgQ
         xF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766859236; x=1767464036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/yiNmEm36TsWNfUH8F6Tvae1msGjni9hNs8R/sZzZE=;
        b=nXfGIYbFCDCzmVyM7wYeA2ytnzrOaM+Vm5q6FRBeimwEhmotNNoC1sXQwHDR0oSXs2
         TGpwisoFWPvRH86xdfOPGqaCY+eqvEH4z1VADdYr8KxPVZkpvK0H1eQ8+7yjdaGu42Av
         rFmwCryMPjwbrcfr4lFT0XmOqxTbPMSpyW7v8pqB6ZOCa7SpBh34B2TUPACVdrvfv6uo
         j/CZCgeJddlq0e2lzsnSO0AmU1axO66cJUPK8/881IwQPVUcdIHndyj7mgY/csl/BXJa
         qapXcZsOFh4q2dj/8G0bPIDwWgxp4vLLFgwHY7wnfVagADghdZeYq7jjvnlrsCnV7nvz
         T4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkbS4RKYBvs9Ds0QhA4MVFneD+JcnMxbl8PHJrfcho0FWXtDTdTvI2Z9XaIrAuO6aDLIz8/5yBEpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZqWs3C2JClDmDZUidngzB21dTuPK9pxI70Q2Gq+1A5ql0yet
	+4hnK16s4jVCaEZS848xyueaRRBcV+jPnN9ooKYbIuuIdyj0P28ujySpHRe8yzkJsYo=
X-Gm-Gg: AY/fxX7QLvbQIKvmHWx9eQCbi+NqHe8uz6ZpTllgsNUVN2nGF9DANK88nqoTbxkNMVJ
	PMMj5V4M6ISYIEC4Zx1HdAnKNIG5T6rfforisLB3ibyln7g2liZ+sreBx2t7QLzOCRf2P8j08G5
	DWc6wX34H8COLvDtGOnK2fhR1XynNoGKq1hP58yrXV+jeHrq7f+ubJ38u9rl6mP2JHdnbh9kla8
	U9WO3p+9TSAg2XqHbOOY7EljB7Eo8iHVDvjFSvC6JHLnl1+aD2DlQSseABcMA1ZCy4JP/F8i5sM
	PRJC4g3fiCvBcA7Ohv9XJ2C6oUFEWj2EGDGYjK53u142xCNiTHTs1cb9TAMohYRNhfbWp79AnLN
	zHrhDrcPrbDdqKEuoR9oWNm1+kT3H0qIDTsPeW7mkoRNRBXwT8FGIpKWKgAg8+5r4hO69t2PxfY
	3B4eAA4BT8b4oSZKFptJKLJJR7XfWLY6Hn5/0Oiep6g5NnzOSfcXpq7H30b8Nn
X-Google-Smtp-Source: AGHT+IGRcPFLai4mdcLU0/c8FbOjABdWxrmxqFWaowe+JFLVesdtVhhbz4Mg5CS3rPVcjo/exX2ISQ==
X-Received: by 2002:a05:6808:5393:b0:450:1116:d74f with SMTP id 5614622812f47-457b213f198mr11926747b6e.27.1766859235858;
        Sat, 27 Dec 2025 10:13:55 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:81b7:1177:37cc:3153? ([2600:8803:e7e4:500:81b7:1177:37cc:3153])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3f1db46sm11302546b6e.21.2025.12.27.10.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 10:13:55 -0800 (PST)
Message-ID: <c4b3fa79-97ff-4f5b-a3a0-f1c24e9349be@baylibre.com>
Date: Sat, 27 Dec 2025 12:13:53 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] iio: core: Add and export __iio_dev_mode_lock()
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-1-6fb47bdaaf24@gmail.com>
 <92d07935-b2b5-4cf3-bd45-654d77cdc23b@baylibre.com>
 <DF96UPJ1TKP2.2U8D76HGLPT09@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DF96UPJ1TKP2.2U8D76HGLPT09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/25 11:51 AM, Kurt Borja wrote:
> Hi David,
> 
> On Tue Dec 23, 2025 at 12:19 PM -05, David Lechner wrote:
>> On 12/11/25 8:45 PM, Kurt Borja wrote:
>>> Add infallible wrappers around the internal IIO mode lock.
>>
>> Not sure what "infallible" is supposed to mean in this context. Maybe
>> referring to autocleanup?
> 
> I meant wrappers that do not fail i.e. return void. Should I word it
> differently?
> 
Ah, I think you mean "unconditional" - as in "not a conditional
lock".

In the body of the commit message, you could spell this out more that
normally, this is used as a conditional lock, but to prepare for autocleanup
and we need an unconditional lock for the base guard() to be extended
with the conditional ACQUIRE().



