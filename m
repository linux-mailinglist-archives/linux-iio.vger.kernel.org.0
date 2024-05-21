Return-Path: <linux-iio+bounces-5154-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 077C18CAA8B
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 11:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B461F2290A
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA21B5732B;
	Tue, 21 May 2024 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKf0BoTu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA764776A;
	Tue, 21 May 2024 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282884; cv=none; b=GSGBBwyaXPcrwr+7BCqaYVwpqS/zdaSvbOwFDU1Q2f3gPvE9jG9VzxIMSaHimIFrjVOWQm35aeCe0eqhUzuDaIHRNMLDHhX9M4GFQ8Dy8p1sfmNiBhgdwZefJkjtvlmNGE/8IDZ2/8k6DdiyC6ggEacFUEIHS8EFDbYy+LEeGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282884; c=relaxed/simple;
	bh=KFQK1c4PQyE7m3PzOehKHpBHvcc8reWa8UWw8E/vUj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qz634UyzOZ3zvQWvjhozGmI1OQ0+1PR/kzA1cMzCtngY/OBcirWDDwjWhKrSIiQzPkif43ctWup9wZty4l+axtZzIcBIU6kEq0deewsAH/d1eJZip/QWzx/zYHC/1eoeJf1GFcpYwMN1r0n4anCKYT4Ttah1xRSa7qwxSVST8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKf0BoTu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a599c55055dso795095966b.0;
        Tue, 21 May 2024 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716282881; x=1716887681; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KFQK1c4PQyE7m3PzOehKHpBHvcc8reWa8UWw8E/vUj4=;
        b=WKf0BoTuzHHlEtiB53BsfRqn4jEP0yEFSXBP7fOWvT5QWuC9RMQpIO10rkJ+Ft8+wZ
         m7dv86j4LVOpU07HHbwdwRzeeqNcIuNgvYj2O6Ua5XnoMbUOmDcXdYvdk4HuqErdVWEO
         PxivgHo5ePliVXKaaYUuQiDvZEInY9tePwGAJIhtR/Dayc0cFgbu9+4+B9KGkM3gsJdf
         rPo4fVqamhlhlY0wbClUhiaIWRJdFxnEg78qLi+6eLa/fb1LMlHoAsKsOPTDKfAo0h+S
         lbcK4S0vezdYGmUu6HPGvTY7+at//D/kJQ6TyAlnEQCW1fgP7Owl75AIhsAoYaxDh2tB
         kCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282881; x=1716887681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFQK1c4PQyE7m3PzOehKHpBHvcc8reWa8UWw8E/vUj4=;
        b=XqDgMbh0xAurifUrqraS1DiiJxS91XtQSXZ5/zU2iQ7BZf0dNO5b7qunDn2dDPh/Hy
         hlZbmBz9s6u4VJs8+kkhytGp5CclSo5JMtZ2H1S6MRFSIQ5NSEUq35OKncEskBZGS4uX
         kVcD99JhiWD8PgYwLnaJLjvvpBxr92b8pajPVo12X3HdKM0gWNCrZBT4cJiS2yOEUJP0
         VFiYN8xGwqT6uZAbawmSKTCihTowglfQbd3bdRebUzCD7tEtnT7NCfreRRoLMBr1kJUh
         B/FxtTLacmIVruL/ViKkJ514FJvocU8WUETSHyYl8iiaMLQNzdqkN80jxgSgDKlLu49e
         pGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvdYxZ3Gek0fT/gVewyFLs/gcNYAyYH2qnNk0/GVyhaLzWL8T2xiblgRt0MtVe+Kklxdw12x+T61BBjPKGmnhepXjU2Xg9mtCd0LSJkx0g1wLDbpgNI1h1fXcQ5Ly/UkWtJ0uzKb31
X-Gm-Message-State: AOJu0Yz+v25TrqmvENHWlXYLv1YTIiGXf7cySmAZJccqrVGmNzR+Sf00
	QKMos1sklCqaJOCApF5kHEl7Cd84wCbWC0Yz9okvHHY0GNLcP3va
X-Google-Smtp-Source: AGHT+IE/7gJpJG9wiUiEYW3ilUdR4829vb87RX4BE7XTz5YsALoI/o56dKfV0CPJZj/Y/y8iIT2EKQ==
X-Received: by 2002:a17:906:f6ca:b0:a59:a0ec:e02d with SMTP id a640c23a62f3a-a5a2d53b08emr1739780166b.8.1716282881293;
        Tue, 21 May 2024 02:14:41 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5ceb46c33fsm668469666b.142.2024.05.21.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:14:41 -0700 (PDT)
Message-ID: <e1277a004b5aef8e6b407089ac1e3df6ff6fee50.camel@gmail.com>
Subject: Re: [PATCH RFC 0/4] iio: add support for multiple scan types
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Julien Stephan
 <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 May 2024 11:18:24 +0200
In-Reply-To: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
References: 
	<20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-07 at 14:02 -0500, David Lechner wrote:
> Following up from this thread [1]...
>=20
> Unless I've overlooked something important, I think adding support for
> multiple scan types per channels should be rather trivial, at least in
> the kernel. Userspace tools will need to learn to re-read buffer _type
> attributes though. For example, it looks like libiio caches these values.
> I had to restart iiod to get a proper capture with the iio-oscilloscope
> after changing the scan type at runtime.

No for now but to add more future fun, we may consider in having something
similar as hwmon [1]. Hence, userspace could do things like poll(2) on the
specific file rather than having to read it over and over...

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/hwmon/hwmon.c#L=
649
- Nuno S=C3=A1



