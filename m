Return-Path: <linux-iio+bounces-23319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6CDB37355
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9052D464E0C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B130CDA3;
	Tue, 26 Aug 2025 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+K9RdtB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02A30CDA0
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237385; cv=none; b=Kw91NunRhuj0qfOv9BHC1kbWlM9ZN+Wor2DQ86qDlJtGYZxqFGG5FDoCUqabGZTjO6WjupPiOouFumtzQ0fV26kDyT76fFhKQFR8ML427+KyQ22ni0T1950oCeyyxyxuHhpdZ25PrpIPnShyemzu0IBks1e8iHyYIz2vEQvyj1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237385; c=relaxed/simple;
	bh=LvQe/BpNjn8bn6jp4Tt7K4HhcDgqBNu2fVY5eKQaPKI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ih4vNP3/LQHFaLN99GSvBhLN/Jok/CSEvAK5/puNejm0QA+zmHi9Lm2kIi0NqRA3173Wd9ILWAa+ltzPJm3u5glbmpgfkcVVN/2yFtKFMSxEiZx8XTAZtbdiH8O3NeJuOWJUTViXEvbMGsTFjZdsplFnXELnzJAlTB2A6dU4Ho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+K9RdtB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61c38da68ddso8142740a12.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756237381; x=1756842181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FfL+ngd7KhbcAHFsv/1qrUYzK8qx3sWC+Nmjao33YS0=;
        b=A+K9RdtBdD4QQn+9BRcLBmtOfXEvoeJVaV2tbviDE6kdEDrlrRU/hA4Ot09llBjYK7
         Jrw91YKyVw8vs6XwkODDHI72DcrzhpGHmgHfyvmc4olI2vR6PIRWsdEyECGQOk2EnzDa
         FZVJ+BQNB5XYdnKZSwsT0gEaAz1tPjNJqvHMV96N8f06mINGwqaa4/7iIFV6AOQOxYyW
         nZrwhnZVHRS+hUNYeXXxzIvM78bKIALZMaX1WYvHw6W17Y4FrcQywzUdkHdhpM/expbR
         NizC3rDQ1iJ7ygjN1BGm7QrAAyoDyg5g072crXImRuadQEg3baoxvA4ecJMCaTVxJK81
         /zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237381; x=1756842181;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfL+ngd7KhbcAHFsv/1qrUYzK8qx3sWC+Nmjao33YS0=;
        b=kbRYfI9W6VHHhqiJQPxVtz5ciqwjhTmtxAGO6xmT1nWTeG/K1cqJwhR+duPk8PZvws
         URkD0EQgpQfRNHFoOjRUKrJy/gkNLKXziD5AJ9l2QH+PB+G8IpvE8c91LO3PcwJis9P+
         Xha23HGCYUTGYmwq9Jk/7DEe14ZG62nTih/IZhdn0vhI4qW+X0Ixz/h+xJIawbM39QEv
         CBTw4OdS4sxEzhiWSpvGbZuhM/XSoxO5g9pjJQOaIH1+zNWs7mb29kAWZM5UvvR3RoKB
         Kxbf1nJkR/JN+bPfxlpuHtP3XXHX2o7E327n1cSThppM1Mo+peSSppB/JEyKtW/T1una
         NrEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoCp7tZrp3CAxBFs5ycqHfPHecJU+przg+YscbaEOjq7w3Um78F0toFAe807yxoPYrAkZvhPMvXiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YznE5T4A7ls3BKsOjh2gnpgYPdfT/DJmxyhThNQ1UKZ4AJx94p/
	6Ybm9jEp1YcRGTpSaSWj4tCY6In8sC2o/wQoGmeZNZK0NSN8XN4lZLZvlHW1ag/oFCJXr7uLc/J
	U05VfCyv3/5w4GEkRgKBHnaR4wOate/I=
X-Gm-Gg: ASbGncvkv1YVaL5PEbfOlSCAUoixLZQeRgdlngr9euQrxL7ivlu7AJwOhFxV8iJO8Ee
	U6tt3aiLhZ7nn+7HVNsDrCAsbe66fhNQB4XpTkBTYOzNmcm0VK2eYLqIq4TjYyZIfLO/ga6E1+c
	OCdsSbZwLniDLIuRzDXaNMbUtCOcknsOe2+Ai62N1JDXIwPGj8CsUst3tw+/GU2mP0Vef8kFzy9
	vawgIeaVK1XaCpMkZIiqyCn5s8OhagmhbfpwFXU73hEuLURaHa1
X-Google-Smtp-Source: AGHT+IE19iKwq1z17FcaMnPZGDa0Wt3IrfzGoLObNJRTmNPEZvHD6T+1QTYRrYNIpvzgr4vKhHclNVCy+ChIxoKA/2c=
X-Received: by 2002:a05:6402:5194:b0:61c:93fb:a33b with SMTP id
 4fb4d7f45d1cf-61c93fba6f5mr2628019a12.21.1756237381195; Tue, 26 Aug 2025
 12:43:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Wed, 27 Aug 2025 01:12:50 +0530
X-Gm-Features: Ac12FXwCVC6eWjvYa4EZGiJcdtxDkno_Tc3ZmoIMAyhZS-xldZJcvmo0cbhivq4
Message-ID: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
Subject: [RFC] chemical/mhz19b.c: Integrating mh-z-series in mhz19b_of_match.
To: "gye976@gmail.com" <gye976@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greetings,
As the mhz19b has been discontinued [1]. I was wondering if the newer
series sensors,
could be added to the mhz19b_of_match, particularly "winsen,mh-z19c"
and "winsen,mh-z19e".
Note: In mh-z19 series 'e' [2]  'b' [4] doesn''t provide a
communication scheme in its latest datasheet, only 'c' [3] provides
such a scheme in its datasheet.

Refs: [1] https://www.winsen-sensor.com/sensors/co2-sensor/mh-z19b.html
[2] https://www.winsen-sensor.com/d/files/mh-z19e-co2-sensor-manual-v1_0.pdf
[3] https://www.winsen-sensor.com/d/files/mh-z19c-pins%26terminal-type-co2-manual(ver1_2).pdf
[4] https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-manual(ver1_7).pdf
Thanks,
Sidharth Seela

