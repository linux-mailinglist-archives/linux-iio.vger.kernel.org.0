Return-Path: <linux-iio+bounces-23809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC95B4634A
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 21:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A3DAA0DBC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62326F2B4;
	Fri,  5 Sep 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F8t1sIzy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13663315D2E
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099573; cv=none; b=ChNuET4Y+VE29b0IoSwHYLRsCR/jgk893h5Mr6VajG+Jk6F8A0RlkPEb/b8BQXtf0MO7NgTHC8XHiq1AhjiEmadnioXJpvk99zfFwFJE7kVD8yBtoubK02b1omICz22dx96CQiCpu2sD8JVGmrt0kSkIRqmfymsD1By+kR8N3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099573; c=relaxed/simple;
	bh=mLdEKkleOIiWpxV1JKcisV8rvb3de4+UP/9768V4zQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAB3ToeW3tycrHwGl4sEwEnAAYECLukCwtMBinADlSQiX59klKbkAxhdbp9+GC/uk9i7qn6kA0fVJUhOqq+RoHP7atygvKofbZre37ylfBO2Awxhur9eHwoI28RKaDDFu2MvEbc1qDkphZEJ1syEiOhLUqe6edLPaQ1fFtU1XJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F8t1sIzy; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7493d03f448so146250a34.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757099570; x=1757704370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TioyJhhVEzIAe8f58I+kJz85e9oFUFmvW267v04uLm8=;
        b=F8t1sIzyzdw0bdUoRkazxp0+MxdZQ+Gl8lxBsWI3Y0CwmFInig9OaTxnAdJoXal2h8
         3yJ/W4HUHaIU+7dtuKQ9KDnsnFgxJDGvhNtc3Qfnhx7iVBrOjDQFlqb7nrxIaXvhjPQb
         RE/kd2MNgcKMc2wt+TqDixbCkM04JE1FyN3bTyy3G0PKj9mDayxNdlXS3ukHalvD2dCI
         1/63o6OphIk5jnasK0t2ANo2L910XMlajjYtC6pMhvzynPJo+V967VJiD2175/XfsHGo
         h83FveTUWzUfthCeLZ0n58DUoNonFz79zE966ut99ovoUi9RD8A9xgq81EAc7hOf1emy
         /N3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099570; x=1757704370;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TioyJhhVEzIAe8f58I+kJz85e9oFUFmvW267v04uLm8=;
        b=O13GStwFVQbg1Y6gwzl5uuKX2PINnzETUuVcyk65KNG4VIq/p1PRI4fjuWv8eA5A8m
         Jmiphj+vtXrkMpC3Uf+ZvBQb8/JEY3OE0yElrgPANiuP4ijkxYiAPur22/V8PUlge/F4
         JlxPCWWeVcHCw9ftI9rEfvF/fyNlEauR37iX+4L3BH5icGsZ7Ml8Vyx6B182++9ohrzK
         ilDKnitnmnnbzr7S7byTlHxVcTRHOAQapuJ71YA6Fsaz29D+amb6YQGG3OWUX1drG2am
         YZz0V5pxSiHF3TuolPTXoKpCWxitzgPUOiZjvh8hJLY/t474zY1z/JWMXT6oCktwr20T
         43hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVssiigvBdYYnKxPBchcLVzG/vdJ5bMW2WLC1Q2Mnbq+hq4mNYTSmx99KOl4BJ4lNQui2udyRqZOnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOi8hwuxTN0hUDegLh+MXok/SHSP03nV4LsiyPItJt/I7FxtO5
	Gi30ABWJUvMlMzMU5iKa6xKCYgVGHe4WL6xplwxDb9KCYox+LY0HD2Kt0VsDrC80vrM=
X-Gm-Gg: ASbGncugL59r0IA3NhlNQXRbzgisOeatMTEpr5i6N2XMhPbfIrpCezNlnL1KiETTGVo
	5DdWmivBaVhVDpTUPUHB5CdEvNA5psBZ4UJsaYhCUWSS73t6r4uJAZD8fYrXyMQ8sXPxNfu5Bw7
	il+TvIfErZCc6IxKv7jPYvyxszBhkQiuJqetH1FiTVpVdn3OhcN1TDktyPRQ0/xXxDWYT0AUnbH
	sCVxqLN+SbTuL0JNHPeiweTsdrhbDGFRm6E0rMDuCWzfLchrwSTAiO86joU7wvX6KlgOakxwrUc
	v/4XHG6eGX1LEs7ir0sL9ESxCBiJ3YZrtnirAtcGepEtAPSS7k0vUTl7WgvlN+LUzW0MXwrV+NO
	emoamSGRxUc5PLx2OAGemGNpqKQvdNMkvFqvI1VlvKTT4QigNFvnAdrErytMye2p7Zc8G05B9LX
	0SuVew/ik=
X-Google-Smtp-Source: AGHT+IFvxLELwgBBkDmfox3AKDtSmZMgKfjNu8Lp70mEFRXLWgPGpfup1VXussEnIBocdizemSXW5Q==
X-Received: by 2002:a05:6830:6a91:b0:746:d9af:6664 with SMTP id 46e09a7af769-746d9af6c45mr2275715a34.20.1757099570050;
        Fri, 05 Sep 2025 12:12:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74596b1afd4sm2897852a34.20.2025.09.05.12.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:12:49 -0700 (PDT)
Message-ID: <fb550af2-37e0-40f2-a44b-52962337cea5@baylibre.com>
Date: Fri, 5 Sep 2025 14:12:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: mb1232: use stack allocated scan struct
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andreas Klinger <ak@it-klinger.de>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250722-iio-proximity-mb1232-use-stack-allocated-scan-struct-v1-1-b4ef77e9ddea@baylibre.com>
 <20250724112628.565aac47@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250724112628.565aac47@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 5:26 AM, Jonathan Cameron wrote:
> On Tue, 22 Jul 2025 17:39:17 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Use a stack allocated struct for the scan data instead of using the
>> driver state to store the struct. The scan data is not used outside of
>> the interrupt handler function so the struct does not need to exist
>> outside of that scope.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Hi David,
> 
> Applied to the testing branch of iio.git.
> 
> I don't suppose you fancy a follow up to take that irqnr local to probe?
> If not I'll get to it at some point maybe.
> 
It is also used in mb1232_read_distance(), so this wouldn't be trivial.

