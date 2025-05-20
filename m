Return-Path: <linux-iio+bounces-19747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0067CABE515
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88104C63C8
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 20:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C91E22E9;
	Tue, 20 May 2025 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXQyNNd+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8641AAA1E;
	Tue, 20 May 2025 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774054; cv=none; b=chXSyzXKJxlKYIMrTZhT5edvAH9ShSpfOXQwlIzVjazONPddvwPH4JjiR6j1e3yJYfa5n6aZwY31B9bkS7mu+2iph8/guztLprpgQUN5OvqJlVURjIA4egjHqiIotn0jck/bNDvd8IvLC7xSk3UAgrdUhJGKAlmAxJZ19deFnUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774054; c=relaxed/simple;
	bh=ZlhPRDOQq5cuSzYEouiUBCPS9mWtaeRxcQTVsoQCx14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHCdk8nNRmtgPjnNjoj/xai9wyy+imyPJPijSuuQdYGF+RguDWB3dMw3MKjPqyeBgv/G9qlJHJEx/yRUL2YvTsaI+bYr8UpSsPJawjumSRdx4oDMGPCDZjtt9ZZM3byov4A4vrBWpg5c38x/SHA05CcA2TANlkhcSOmAIfjaqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXQyNNd+; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4c4ecf86e8bso2063147137.2;
        Tue, 20 May 2025 13:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747774050; x=1748378850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfGJMBy2dxd7CZi6+emvPVZAGM+Inq3wIUnGhP15I7k=;
        b=LXQyNNd+RRZHGY8JC6DZM0MLKaizAZOL7RxTByHCeFi6f0KFM02+DRWWD1UX5q2Bhp
         75inpoReHeja/1Q9LryId5srp6HP5zY0hxHvVYT0y/mh9wGloWvy5lRQ/snwcYsKvh1g
         vFD57GTvp5YdkafuX8zErOFJaBniZ9cM6N8vwxbGE29EJ9xkwD6WnJbNNvw6g2QeCby9
         xBpYrQv+CIH8fdONi688irhxzNRH511m0jprx+J2tqy6aKftemgsL4M0JH4XlxFu7H9t
         JAACUNTG6qHI8xSWrG1/DOTQrN3ijUd0Rl3W00j/BmkrdkO1Va4CrQt8RpsjdNX+5esu
         BO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747774050; x=1748378850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfGJMBy2dxd7CZi6+emvPVZAGM+Inq3wIUnGhP15I7k=;
        b=TFA1SuyRwp7mxyPJIwV7YMg7wmaSwYs2RxqHqs4b9/H/Bg3l1EybjSthrzHfmrPwee
         O/GtExYVlAZz5Jwm8LwlwL5g2V6CWoWxtPnj9+47hqbgWFISj0YFdxvMQomtsaFqfl81
         v8ZkEsTIXJ2fzBYR9JBNOfAl11aq11f+7HjunjCIx8TdK8Q/Jwq+PuqDncqinwgJkj9U
         UV4h4QWENHijP3JjTgtCr+UH7Kc+r04XSCoEk/Siz5Lyw1S8icB6xzsFUfTRybFvi91C
         99zogLlBuaHKL+im3f8KDiZXKvL3j5tBs35K0p8ao3wu8YZqeBJCjc+oR8IpEQ/M3K4W
         Fnmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Xdf0jlVdrh4NEFISZERAeHuzJSP9Nomy3YvOIQBU4iiS+0MD59GuFudGJvpu2OHe8yFnBTvdKAcn@vger.kernel.org, AJvYcCVwBSlLZug8oJth7zonB+bjfhdm70AC9c9/CHIPoVsYQDJbok83vicSiRngcsuImPfZM0yysLukSWLtJPd8@vger.kernel.org, AJvYcCXCcl+1MkR+GWu4+Q1joBQl5REtVsac4IgQChAfHf28K23E37RGLcKGA/SKAxfsiy/HCfrRksJkWjPw@vger.kernel.org
X-Gm-Message-State: AOJu0YwzRw1+54ZKupi3bk//Jur7LZS/N8UgmPyWr6WmWp5mjIMKJqzW
	njmW8E+khsQsJFuK5mv0K4e6kFTP+5S/qZ4d/6dBWEsJ1H9Fi4oZMId2
X-Gm-Gg: ASbGncva02lKbq8jG3F3PeCDzOXSwM4Z+hsl7EPzSCJT464l1ccV4gfWzmcs55AaGZf
	2G+7x92WH6JQRZqlGPZ81ixDDH3KqxciUctJ9VqIrmtTpOvULk9+OJJPpLXnimr7hGskdiJOGxD
	tNeMFP+x0iUYlp2SMXZjYrd79mnkdXX+2w6No6HafOud1305cmGX3PKiIOrBNGo6IJyq6te9aZW
	Od81+0BBJqh2GFCx3mSHAWqKFDXhfQVugF5+UzeSPaNp8Mdrfso3FgAuf/Op3Gi3Z+mveEvNz7f
	GOmC13IFSn5KjYOfeJPZENz5cp5jG3VrKjHyluJwbF6VQ5ax99zCtYP6965w7Qx60A1TVx0yFHE
	=
X-Google-Smtp-Source: AGHT+IHIyn+7z0vbP2fMl/H33rUQp0OuOVixMKKUcDUG3gGs6FHgPmAiG25XvucCHnyG50pGBqYAeQ==
X-Received: by 2002:a05:6102:2049:b0:4e2:83db:82cd with SMTP id ada2fe7eead31-4e283db82e4mr7262637137.15.1747774050557;
        Tue, 20 May 2025 13:47:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4dfa66f056asm8623968137.15.2025.05.20.13.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:47:30 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: conor@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v2] dt-bindings:iio:adc:st,spear600-adc: txt to yaml format conversion.
Date: Tue, 20 May 2025 17:43:45 -0300
Message-ID: <20250520204720.11448-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506-equivocal-snooper-8a7d1ce931c8@spud>
References: <20250506-equivocal-snooper-8a7d1ce931c8@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Sounds like it's a 4-bit register where the samples is (1 + written value),
> and the property is expected to be written directly to the register.
> I'd then expect the property to be min 0, default 0, max 127. If you
> write 128 to the register, you'll accidentally set the external vref
> bit. I'd maybe go as far as &ing the value to make sure out of range
> stuff is not permitted?

Well, it looks like 4bit as you said (bits 5,6,7 and 8) and 9th bit is vref.
But, in this case, it looks to me that we can only configure 0x15 as a max value,
(didn`t see that before) which doesn`t fit the datasheet sentence that I`ve mentioned before:

"Programmable averaging of results from 1 (No averaging) up to 128"

I mean, I`m not sure how many samples are configured when using
SPEAR_ADC_STATUS_AVG_SAMPLE(0xD) since we don`t have a register map describing
how it encodes that internally. Maybe we can change the requirements for this field to be
min 0, default 0, max 15?
And at the drive side, we could use &ing as you said with 0xf before shiffting?
If you have a different suggestion, I would appreciate it.

...
#define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)
#define SPEAR_ADC_STATUS_VREF_INTERNAL		BIT(9)

...
		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
			SPEAR_ADC_STATUS_START_CONVERSION |
			SPEAR_ADC_STATUS_ADC_ENABLE;

Tks and regards.

