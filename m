Return-Path: <linux-iio+bounces-23982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA810B532A2
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 14:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A9B7BAAB6
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1830C324B1A;
	Thu, 11 Sep 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/ZfSOA4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B908322DB7;
	Thu, 11 Sep 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594636; cv=none; b=RVEJdzBUUYvPSuQ8HXgfXTVriLtXR2CQUIwJZV09KxMjJ9HSs7PIKMo9V1LnftGxZ6th1hNA0lCvUd2te/2CzS0Pgv9jd4i4/hD/X2G0I6vc7CsriF9R992g1w7RKf7PJnBt8BENSHXk+g7C5UoiP0J589WyKzwR0fjl+Qail4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594636; c=relaxed/simple;
	bh=xe9Gywa0nrV57XMMQehx9rCXvTi1V7YVWIVSt+PJfi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXpRJbaE4N4Qd1LHhCRS418Cair9SceVmBlcFcwlAtrFuU8hUT2Qkwbb/CxPg+T0bTUF1p05KwKxC6WRP+SFF4B1Y+odz1KXewvAiQHW/3VrtB9Gf27VmuhAgn+IH20dvM1/OEM6Z/XU96VSdmDfAXQAUvEdmj9PyHjTVNe/PGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/ZfSOA4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3df3be0e098so482732f8f.1;
        Thu, 11 Sep 2025 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757594633; x=1758199433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffstATfAOIYcJlHHnicc/Ajw/zJxaIpci9UFmXyAMeo=;
        b=m/ZfSOA4i6JwaZtVe0X8vsbmVMQCJklHAfVlEDSFYh/y2AActfVUX0FF47m5M1uV38
         o1+k6YPxVle4sdrQDMV8ONfH+WJLXN3wmahZ6ic+jNlfGiaj9inlKFPgBRiEfHV3gBqU
         IjpCeJxeVqDZ7d2//eILa+JA+cdGsCRU/GWbW6EE//0aOmDOoabmIG82npQ5drYSV2Wb
         Ztr+SVjiXLmtNRDmjxDUbb7j7fINPrxBZBm5//wbsk3uPh1xrl75kG4Xod+DCftREeoG
         BEyv423tUhGVi0K0EaZe5/ig2nyVgI0ojEOm+PXAwmri2ZHxg4oxL0BbCFyJKDBTeTb9
         bNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757594633; x=1758199433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffstATfAOIYcJlHHnicc/Ajw/zJxaIpci9UFmXyAMeo=;
        b=I0to3CdtnwQ2mGpH/CzNL+OVUdNb+jFoj1RsOPgsB4lKIO8KnFkhmUHfUC2MOIwmfj
         D3ef6vE+cUl8P4IQ7BIVeR2f0r7gx5JxFaSSwPuf/yduT4d1A2NRL5ElsG7AL7T+Gk7H
         JDcJjobWIQbUuBBLBhxTNfkQu1SXKmiAEZ9fP5mXKC+hp8bA6BKrYz8YcLvX+arws6XC
         rmIklx3+CG1+Guev9pWRnTV1+gmBCqfDIhqbvu/t+KuMQMwsivQOFDIbJhsQS0kteazl
         xUdzjw52F/KhV3K3WoaaTcCGbrrgaq19J3L083wHPVXJ4b0Rrx4z7bWLtk4loi6ylRXv
         USrA==
X-Forwarded-Encrypted: i=1; AJvYcCVdALz3eWSpYNPqigNUW2A7UjsqqopqngTfpjhbX/3XSed8kKJOl9jAo0acfMjRwYW+BCbXNLa9mr7jRb4b@vger.kernel.org, AJvYcCW/WeF58Ww5T+VNFXQzGgIlWVvTLYOQdFP72fHBAmYrrR5CGr0Afkx9UAZh79Hz6vGAXGIKplcC4fRb@vger.kernel.org, AJvYcCWYg5fLsU4CstDyL5jU9+pINYT+Qy+Q4GMee9o7M6UNMVZwWXqgUmdbHwka1lghU+dnxqUGDXsuWzej@vger.kernel.org, AJvYcCWyoSXcEg8/73Fsu/lVV2gjVb8d73DUvAVIZ7E+YNJHmLPGoPuu/EmHlStqIAJ9N2rMJDIJM5E3nF5IPe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsM/RrwheygXcjoJZTVXkGl6qdj8lLAd/wyWghkP6+J64YKWb
	A+jDiQ/MQarfdfzaAcLRcMjFjaBFQvocMwB+3/9hwE/S3KYvytm/PP3m
X-Gm-Gg: ASbGnct6m+gXJiga/7cwEi4/UdT8oWCOLinmFjFI53aFMIvAwI/7yO1EZBucjOJI8E7
	Y6BQXGlOH+Re6ust18iS8VlFnvWsplM3HttD7mPxfIZ91hrlKHyFMo8B4eWsRVPHC+VYhI29OC1
	cA/2tjmKcTtO2KNxuefXpLcZcymj/aVsgVBla+sR52BFhsCmaLUOELZGjnr1+v6hBoeNt51JG97
	2lQ7Kld7oKSxL5C9i1dsP3TElVz5zEFZwULgtv6az0HJJoXuk0+ehqXRtpHZVmktexhMgnhWcz0
	nF5831uOR3zB4E6tSQuUqVkDJU8uCjcwWy1LYZ3K9E1EuMODeCL3Ihe2wczGomZN10cDi1fdB4M
	jcxiphIu0NLGP0KVeRLgNXH6xYUB+/ty0O1DhexEN5SJ36Iss2p9aCnuWa8ZruYJEIKMGix9qQd
	ua
X-Google-Smtp-Source: AGHT+IHMo/U3BdX8IVk6itPiCLbgeG+HLRPTKaSeSv6yYfTnMgD79N39xh4sXUrfzCHQln7ROZ0dMg==
X-Received: by 2002:a5d:5f96:0:b0:3e0:43f0:b7ad with SMTP id ffacd0b85a97d-3e6425eb809mr13914249f8f.18.1757594633350;
        Thu, 11 Sep 2025 05:43:53 -0700 (PDT)
Received: from Radijator.localdomain (93-143-13-188.adsl.net.t-com.hr. [93.143.13.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e03729c76sm22591495e9.6.2025.09.11.05.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:43:52 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Thu, 11 Sep 2025 14:43:46 +0200
Subject: [PATCH v4 3/3] mfd: 88pm886: Add GPADC cell
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-88pm886-gpadc-v4-3-60452710d3a0@dujemihanovic.xyz>
References: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
In-Reply-To: <20250911-88pm886-gpadc-v4-0-60452710d3a0@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=duje@dujemihanovic.xyz;
 s=20240706; h=from:subject:message-id;
 bh=9JhG6l9aYXd0tr5rpMP/JH7+4zmVZlrSGb616SvhYjU=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBmHjjDWzL4o6v6r5sgz0TdidX4tMufuzUvnuGqQwDVLX
 +t/e+GFjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZhIbw0jwwZHC3/Hx2lHXuQ5
 c1qom1wreretz323vIxBVk+JsXbFVIa/Arfv1LXV3VFzepunHDJTqvhgd/fHrsMvPz+dyH6icIY
 qPwA=
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Add a cell for the PMIC's onboard General Purpose ADC.

Acked-by: Karel Balej <balejk@matfyz.cz> # for the PMIC
Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v2:
- Sort cell names
---
 drivers/mfd/88pm886.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/88pm886.c b/drivers/mfd/88pm886.c
index 39dd9a818b0f0e1e5839f76768ff54940f4cefa5..e411d8dee55420e10b6d7ad7069576c681360de1 100644
--- a/drivers/mfd/88pm886.c
+++ b/drivers/mfd/88pm886.c
@@ -35,6 +35,7 @@ static const struct resource pm886_onkey_resources[] = {
 };
 
 static const struct mfd_cell pm886_devs[] = {
+	MFD_CELL_NAME("88pm886-gpadc"),
 	MFD_CELL_RES("88pm886-onkey", pm886_onkey_resources),
 	MFD_CELL_NAME("88pm886-regulator"),
 	MFD_CELL_NAME("88pm886-rtc"),

-- 
2.51.0


