Return-Path: <linux-iio+bounces-23318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCFBB3731A
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 21:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCA81BA61F9
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF419270551;
	Tue, 26 Aug 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xdSyAYyI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3734431A554
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236813; cv=none; b=mG4TMLRobyxJHnhS1wAD8CwmWzoFIMvmapTF24QZpzi0RfhRjkuV8t/zpb3foZ5T2cQEnyzonHoxDM7zm20qBpQpTtrZHmbIrRovebLvE4qghHTdKlL9xRND9piV/feqJKDTTsfaP87h46YfJc0v3MYWnmitNlwZUZiUjFKbAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236813; c=relaxed/simple;
	bh=8mAXObn2zhzFjP8c+rF5rcPzrMNFR3itCTjsQpX1Rxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMuF/xYcE/3O1lA8RjVZP4id+X87VM1YEdMEqmLk6DTLokaCGvHOQh3UlZmKnYAZF4OEsjiRLllL1apSV8KZ3yMfxhveyFu9tC73wRcujJaNk96p12nLxyGR8InIiIIY/wROlvFDzmdomyGsv9VAt/nJcaxG7tEnxRXQb6TYHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xdSyAYyI; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30ccea6239bso3662118fac.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 12:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756236810; x=1756841610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mAXObn2zhzFjP8c+rF5rcPzrMNFR3itCTjsQpX1Rxc=;
        b=xdSyAYyIS5odTe3ELO1wUmFIkRJ+YL6zm4h9Lo6533Gx12ijQPLGp5bN4wzceOweHP
         Mm3pRxzvJu4D08PUOFGxq1RLP9uasvj0sVY/6R51P0eRrvZ9awkzxo7S6kjjWdGnj9sk
         WiyZFku30v1pIvBJ16O0rFtkbqfws6o+YZZn3I90JKZtKmLxQhgi6Gth0SShIchonOkb
         1priukbr83fKPM3GDlg3Oox/qg0KD0x8h8bWuGUrpwqwQfpkRnGLt7PQH9zSElfuNTNp
         8qh7avy018rrEgTMiqVtlRq/Z4bocn8/Uu3RPg/5CPXR3L1hIUVwLhILtqIchBpYR9/B
         cVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236810; x=1756841610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mAXObn2zhzFjP8c+rF5rcPzrMNFR3itCTjsQpX1Rxc=;
        b=Unf9y3ONMBWtz9+3rMNRCuKHgxxLewxHv5JTZcUiGpL2fZmY5l/D0+Tb9JaE8GwRgq
         48IHnWIDgQ+YxIBHfSnAmz3bNLAvsV68Fbbfuy+GrZQPgzFotXLOXOfDJqeV6Po03WSc
         engBIs9m2vTuXajy32cTrBdvZyfybaevKsNpKa5ujpQKz6CDJky4L+Vv/RQsD8bzpaDh
         4g9L9/hSq/G4lxDe6cZD73OTA09zOCSobPiH4980zJvdOnd1DboZES3pT6hDtr9fcsOE
         bUGcYQDhomNldL81YhmgxOcBLD5fZOwSnmqZpv9nnPE8R/5Esv44J7+jG9HkdPwCBma1
         gjDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEJGYicrePgZS/LifN/XRfy08QFv2658qppZTnmhD+dLSqKSDr/2v88FJdkDvWgq4xa1AjGd2TVI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjQ0b12FxsnV2pzg1Z2uafKu5uudDWvqUhiXKfBwT0vG16NaH
	yXh2KpT2ZGC8n8zd1LVcpOsau64olb4DjslpR67ULBhuEUCX4Aa/LYb4fXhPA/7MwRw=
X-Gm-Gg: ASbGncuRAXzZr+d+ElUvU6p2sJa2gA8b/KCyRh90OCP3Ytv9oNs7uw7LfRygAZWeSn6
	SYF4KLgJxZSOtinYFSEM/D3hq+0x6HFi32fgrHkFGp9ID5Vi/YiSi/EXzrkWfRWWYjyk57sdnnl
	UFcAJcqNo/0CpsER2vydazfFf6YdwRJ/pToCPbzDt2Emr889IaKUQ7UOxStsxeAm4z7GyvtWvzA
	jFgHKDTqn0fNVNjV26SLe21EVAV4CwDYG780sYu4q/i0FFi/87DTFitv4hRjWFX7b+uTHtBl0KB
	JfuaSDmSkpfWJJsNY1NvG45ZTTIIq4kL3mDck9RtZlyv1lI6XZsLam0Rnd6dvjtnNKkqDGZ0dOT
	aTGnL6hQbgik68I4TlOB/tXvXy7aQDAVnm4y8v3A9UI4K6/P4EoJwXmrHkJ2bdzsz9cWrxexf0E
	8=
X-Google-Smtp-Source: AGHT+IE96e3ueTi+4l1XgQb+3Z0q645uY+kt2kT4Wdlq/gIGZc6KepaE/3EwdSb/UYukIE5K5hx7ow==
X-Received: by 2002:a05:6870:c98f:b0:30b:582d:8eed with SMTP id 586e51a60fabf-314dcdd52b4mr8242972fac.39.1756236810161;
        Tue, 26 Aug 2025 12:33:30 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7d9852bsm2629677fac.32.2025.08.26.12.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 12:33:29 -0700 (PDT)
Message-ID: <0e475ae0-acd7-4eca-915c-9dd44682db2d@baylibre.com>
Date: Tue, 26 Aug 2025 14:33:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] chemical/mhz19b.c: Replaced datasheet reference to new
 revision.
To: Sidharth Seela <sidharthseela@gmail.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "gye976@gmail.com" <gye976@gmail.com>, "jic23@kernel.org"
 <jic23@kernel.org>, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
References: <CAJE-K+D_U3F_61vzXPHDZV_Rm4Jzd--nO3yf083g7-0=Hh7OFw@mail.gmail.com>
 <CAHp75Vcte3F3VNhKZPd4vv45Kedzok0LKQax1jt=geG9w7b1EQ@mail.gmail.com>
 <CAJE-K+CNsGdJWeYW-NL7PtkOog3YfLEeqJLJRHEtTfb=A=o8pg@mail.gmail.com>
 <CAJE-K+BjnNdE0kN1fqfZQGb+9Gcdead=DRiAXn6qpSz-WKOj9w@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAJE-K+BjnNdE0kN1fqfZQGb+9Gcdead=DRiAXn6qpSz-WKOj9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 2:20 PM, Sidharth Seela wrote:
> Code referenced the mhz19b sensor's datasheet i.e mh-z19b-co2-ver1_0.pdf ,
> newer revision is mh-z19b-co2-manual(ver1_7).pdf. Hence, the document's URL
> has been updated.
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
Please give at least 24-hours for other reviewers to have a look before
sending a new revision (for things more than a few lines, allow a week).

The second revision should have been v2, not v1 and should not be sent
in reply to the previous version.

Also, the subject should be "iio: chemical: mhz19b: Replace datasheet
reference to new revision."

And there should be a blank line between the message and the
Signed-off-by:.

And revisions should contain an additional changelog so that reviewers
know what change since the last revision.

All of these expectations and more are documented at [1].

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html



