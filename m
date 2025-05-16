Return-Path: <linux-iio+bounces-19573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A935AB96BD
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531D5A0044B
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 07:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF24228CBE;
	Fri, 16 May 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAnZM+dl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6B19CC3D;
	Fri, 16 May 2025 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381489; cv=none; b=N7rGTS3Lk+r5qaODZZ+19KTro5luZ7yMo6bPOb43W8P3/MGb5Fov9eBJJmf4RnmiH+v33mHzjdlZmrWTdtLnrEVfA9Pn3n1P0yB5s1Sm4SvGoL3nEezfGME0xBb8BRk6QIWafa5qQ69mEcSlGlNaHXQJud+Ev+Pqx89QwgL84MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381489; c=relaxed/simple;
	bh=KIw8Huc6vUZhcrht53XcPAEGUcuPRVVZ5mcf7sgarkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtajGQUrxDl5tQZRdFBoBN0u0T9k+WiaEJUFunNaZwoJf5GxJZo3ZQbKYEJNlRDh4xCE/tj47cUAqyFAtw2Oq4c30Xf/+3aUWNNjg7ylC4py0t6VAK1O76fE90I52jihNoLRtDEClZBRtE/s+orVgmXFEmIh4rAPszTBzI7qDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAnZM+dl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a35c894313so547772f8f.2;
        Fri, 16 May 2025 00:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747381485; x=1747986285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3BLm9vkXCYt/96TogirZ+THEaz3OcB10jY6XSrA9NLc=;
        b=dAnZM+dl7JhYpWKv8tnIhJqzAFJ+wr9LknNfXOHtrE6zpEtawOqu/9IcVs5lU1Jwme
         7hn5MHPnlkET0RZzXZxmpasq0PxLOxYLVQZXXs7IZlF1dLfVWrrOoIjMf0TF59M/vltr
         sQk81IrOgzKdekDGXuHvU0gc9BCOzB2/UW9s2xYNTWx2zd7j/T4WgWH1t29qwfHnkoOP
         R0W+oLMcA3HFlJBjYLG5yFVx2JPDmDXxN/W+PXVLr11E4JGxUrVzDQyokRZpmTqOOoOT
         GkyCJqQU6rmKXQ/DP5l4rdPOapH2w0ZmnCu9OnphXu7Mh6O9H2sl/4S4LvccZGFRKsit
         aewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747381485; x=1747986285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BLm9vkXCYt/96TogirZ+THEaz3OcB10jY6XSrA9NLc=;
        b=DucNER6goDzhXUZDgNuTt70KugjjkyjHB3d0pUCtvXqmjSyTgWANjXoQHT79LKJzZe
         4J9ml/FnTUpLTJ7LVD/vz1WjDabQeBZAb/gIY4S2L5D9Z86g1hQ0QUGTcKPdpFDnCxtB
         Qbf6cDrSD5mMYh7oyLJxtYnjp9ZH4Q0BSIqaVh8+xZcPxds4TbGYtS4XXUzVb5krbCPL
         +7QxlYGLseOGHmd832MlwuuucQxt2uDLz2LF8LieaWOkpwL2turEQUvsKE0HfDNJulC+
         GusMINxPOYrTc/vVkNgbPIOXJT6O7xVL0LiQz844pEw32vknxnZpxO3609eHY6BjIuGX
         6mJA==
X-Forwarded-Encrypted: i=1; AJvYcCUbJwn2GDkkTUOsQ+Q6vy+9aILlcStd88yxjuNbaWHDvjP95kC3boAoMKHAdQHtJhxS19qZZ+LlrNGp@vger.kernel.org, AJvYcCVaTdfzYY7ho4mN6z1I0N5sRKQ3Idj1XEg6kRnWpVsotsINa7NXSzgw9xm396jxOC6GAwomfUDy+ZnZx8PM@vger.kernel.org, AJvYcCXtEpQ/skyIx1eKb7cgNsoAoDS253H/y+3Cf1GVUYC+xlOTe5ljwhFs3LcGH8SYfu4z/voqCxP/xxQi@vger.kernel.org
X-Gm-Message-State: AOJu0YxqzrbodXKT2gsPgzSciTqQyy9eUl2nu2EhlAGbC5pov52pA5l/
	Fjbw0KxfnCOjuhSWZM8G0dc846vkQG8guhRqVwA8dHUtQqM8PvZOEphX0AxyoKWHQnM=
X-Gm-Gg: ASbGncshSRrmS2c5XjuxTqlGR40EzeIp4yvQUqDGzSWc3qnBi/ZmUWItx+sV+klgR5x
	zJTXofmgRWOPVyWltdrhUiUHZEBTpdgxFk2mZfmr2X9y9AbcpmCQ3XUaOd939U/P6zcobIChTfb
	hvHCsUZGXLLZ14jMaXxpwInZucSa8vrlq5xf/6ZqNVfguRxeHi0HANvc3qd2C9JV6SvSCAu/mqo
	Syt1XuO0t6kMr+bVrCfD8F+ZqRkg37Wx5rPATgP7zJAmmpDhU+5RAjPQDdZKpctz8wnEEPd+uau
	mzc9FtUltgPChuzIzJaM8TtTEeKF6G5VxdNrCz1LSoF58KWbrsb6iPeAyQuQ4c9ttWl26OIgkkg
	ODR/pqjkuOQ==
X-Google-Smtp-Source: AGHT+IEI0iipmLPi0vWLMxoTwpXsqFP5+lcK7QRys9Z6brRkts3HtVxE1z5Eqbv41581z+CKUlTdBw==
X-Received: by 2002:a05:6000:2af:b0:39d:724f:a8ae with SMTP id ffacd0b85a97d-3a35c8355admr2586432f8f.33.1747381484844;
        Fri, 16 May 2025 00:44:44 -0700 (PDT)
Received: from ubuntu2204 (207-pool1.nat.godollo.uni-mate.hu. [192.188.242.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fee0d216sm16675845e9.26.2025.05.16.00.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 00:44:44 -0700 (PDT)
Date: Fri, 16 May 2025 09:44:41 +0200
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: 
	=?utf-8?B?VMOzdGggSsOhbm9z?= via B4 Relay <devnull+gomba007.gmail.com@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: chemical: Add driver for SEN0322
Message-ID: <objvp7ewogv4g7zw4dfrxzdalxlrb2jo2wdpckmmzwtymrgges@naxumsrw4hdr>
References: <20250506-iio-chemical-sen0322-v4-0-1465ac8dc190@gmail.com>
 <20250506-iio-chemical-sen0322-v4-2-1465ac8dc190@gmail.com>
 <20250515174416.0d5c49cc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515174416.0d5c49cc@jic23-huawei>

Hi!

> Will shortly appear in the testing branch of iio.git.  I'll push it out
> as togreg once it's had minimal 0-day build coverage.

Wonderful, thank you!

> > +	ret = data[0] * 100 + data[1] * 10 + data[2];
> 
> return data[0] ...

Yep, sorry.

> If nothing else comes up I'll fix this.

Thank you! Please let me know if I have to change something.

Best regards,
János

