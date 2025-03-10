Return-Path: <linux-iio+bounces-16663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C452A592D6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 12:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C057916B8BD
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85164221725;
	Mon, 10 Mar 2025 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aikdu/La"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846921E092;
	Mon, 10 Mar 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606657; cv=none; b=RcAVRRBmmlbKZjpKj+4v1N+DHwGr79N4utYZNUsM031exqT7xpfPHS74XI4zCwLdn8XQRCOV0NCWZZ1MkfviXouxabK2IAEjqZJ/9RSjAUT02qiEeF53YMAyVlwHz+YStybCII+4q/w5nd3Je6Vm3HIGG3VazYGtkp7lGeyXG0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606657; c=relaxed/simple;
	bh=xuVbDMf1VeRdUabW+uMUnx5cK/8M2qMXtYlZbSIXoWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buaXHk2a7AQA3aHZ0Xm0lsRfTipWtQUyO8LoKUwXLLrJBazOgPC2Vp95SNG7LpZTauMbJ/oIbbF3QWhI50QNEPgqCG1ARMyqUWQmKEhS2DwQ+Eqap6aTHepSKwpSlvEYpF0Vzf9kRwuzV0pujJa/8RDGLTSzQgw0ZNdRwTnry+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aikdu/La; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so724282166b.3;
        Mon, 10 Mar 2025 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741606654; x=1742211454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xuVbDMf1VeRdUabW+uMUnx5cK/8M2qMXtYlZbSIXoWs=;
        b=Aikdu/La64yI+0gMpP4c55wDDh2S2OsqLCmU4WJQKUMPBs3FBQ4eo0KRwpYSfhvCvZ
         UkGeohOWRykXLZfX1VgDK+yY5bziy0c4uF9cjU6RGCLCI7arTgj2huKTz4iBl0YZ1nDS
         5QxDGWHcxHhkF+EsYMugZ12PYElQeqfnwRsybtdoPtfVAhJNZSg15GyoMSo50bOBcHXB
         GKtEkUOSW3IxBebE05HuWTOOa8cCWLAyXEfYVh5ICQy2WGYb+cFfP5uzmFOhdgm5SZlE
         m8j9mKJs3MAfogDxsByzQPUoC7uR2SFfxY7T6rVGBu8Lq6mrc0EOfUp7igf44tKSu9P2
         8VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741606654; x=1742211454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuVbDMf1VeRdUabW+uMUnx5cK/8M2qMXtYlZbSIXoWs=;
        b=QEOme8AiMwdEx8Tpnd6YUT/vs8df5wryUmFZrS9yEOP7HrB+gA8/BnbZD1SUqFEOKX
         ndMRX7p313JfrIm4sjZfZ9FTg/ldyFNvWxn/DbsznqfuE2BWUqqtmTHEZtr1WnUo9wcb
         yetmEvtiB+4S8TuEXKDkrmv98DlP2QZcTOJzhSmVvwnaOn9Ovn9hJbcnIMPbmF7xNASw
         baN9w87pizhj3UCxBpmy9unUdDwJnWYVY1OAcTzDbNZtAz27iNrKP4fBe3mbbLe6zCkm
         ZMtomi5lSiwkNdfzGrBkOSEXVzz76S7J/2RkmY3R4AF/ziPPGZgzdcIrOM//yFw4+fku
         t6vw==
X-Forwarded-Encrypted: i=1; AJvYcCUVNV50RN4wm6vaQ6T5sqrTxs0AofLLDBfepzhxIilnAV90AprRscZ5sZuPahB0lhuzJ0pya5nOKNIa@vger.kernel.org, AJvYcCUiaRkzZDI/8Q6AVAXG6aZjI9phFP2HlH9445YBuIg+bHgprrB70UqfqiLHuqzs0a2zRDQQBVN82KqF@vger.kernel.org, AJvYcCUlPcF3yAlFSiSFv51RvE1Xi0rzSk1sWCoDYlpNJ8IsuSK2Et6qNZGgNrWDlZdo3mDUnoi5EGr2sNtvbUqW@vger.kernel.org, AJvYcCVN+IDLO5GQ9BQqztimph7DRqDOMpr0PidjGbXlc1+szKgUdKOyTiXfoprTyBBrL8sCQ0k9PvTWPz00@vger.kernel.org
X-Gm-Message-State: AOJu0YxQuREQzeUPSFrCY0WnfHNT8Zg8eOhSUIFgum1Evn9bAKKFjaFW
	mPcXd3kMOyyucs0bvnGtl7ZqGWQnqHWaaMl/0fN/WFno+fJOQi5N
X-Gm-Gg: ASbGncv0HCRk9wDovMiUMOgaXCV8h67SkC5yArki5SrHH1j6Mba5+FykbrisJmjrifB
	an7ez/yTjjXthMyoj49RwdMm+42O+hrubiClo9/LgQTduszZkEA2v6hR/F439dyfmW3w5tj1yBm
	+TDIW7ZGIpSWs1veeM9RJwpEO+33C5YqbRrh7idCPnScG36jNYaZqqz44Xj+x3gFfcG9mffKgKI
	7VnWeuMjv1znFELJK0DiJHh25ZvTNe6Gr6dDnwQdCPYgHsisDrxsac3DjwZD1rA/pzquofhN+Km
	eKeHA2s7JsIvcG/SbExB5SpqHB2RX1yfiaf+JZHrGGeLX64aPpYjM6GSPYyLDS2vnS0nzAE=
X-Google-Smtp-Source: AGHT+IFvyMAjt5WUOZojh6S8k1fIfI1ywLQPCK/nEohGCDmNh9mRaR1KUwgmy+LRjwxhUEZpDj/eWw==
X-Received: by 2002:a17:907:9381:b0:ac2:51ac:35e9 with SMTP id a640c23a62f3a-ac252fb627amr1106583266b.45.1741606653699;
        Mon, 10 Mar 2025 04:37:33 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:3038:26a:50e7:149f:5ffb:56d9:92cd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2a96a22d8sm100918966b.158.2025.03.10.04.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 04:37:33 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:37:31 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: jorge.marques@analog.com, Michael.Hennerich@analog.com, 
	conor+dt@kernel.org, corbet@lwn.net, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, jic23@kernel.org, krzk+dt@kernel.org, lars@metafoo.de, 
	linux-doc@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robh@kernel.org
Subject: Re: [PATCH 4/4] iio: adc: add support for ad4052
Message-ID: <botq43x63n5i7jumezv23ll2wsx6ijwwrbzfv3s6p4pul5kv6z@pbvzzo4yx2st>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
 <fe21c55f-9baf-4b3d-b1fc-a866274b6178@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe21c55f-9baf-4b3d-b1fc-a866274b6178@wanadoo.fr>

Applied suggestions, thanks!

Jorge

