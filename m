Return-Path: <linux-iio+bounces-26765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6ACCA4EBA
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 19:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAAF431447AC
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E572F361C;
	Thu,  4 Dec 2025 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I15BF1H8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8A36998C
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764871257; cv=none; b=RpZD1uNK3HN00GB32ep+bQwiy7lbznmF1nK/7AOW96nipLQno8SfOXH07/gcrVqi/KrbUTRbAGEGC7Ba0RWxHx4qGCJ2IwRPL9uMILCKm4PYfH6TaSfZ0d+sdk1u0Zn1WTEru+RHI7qHBMYhqUltWlUO6HBFIfgMevKL2GTrPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764871257; c=relaxed/simple;
	bh=wrUOSAWKU2+4eHuw0PQplu30ZrAwFfNGX6rR7EKHuPk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=WA6qrXv6QLS+am/oKL9ngvPa9pF5JFvWUVkrQcCRO5ex17CxA9L9Oc0YzEwm4LLqAmpnbcpSCozRND697E1gAn4ZL0NkeQ1sP1l8R9I6uxjfdO0RcQQqYL1+VA33UhDOmLq9qRyl64PgHPt3tPYJqoJiqvJ1wSEseLGHgpWSTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I15BF1H8; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-641e4744e59so1223969d50.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764871252; x=1765476052; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrUOSAWKU2+4eHuw0PQplu30ZrAwFfNGX6rR7EKHuPk=;
        b=I15BF1H8NPY3VLmRvn/LC9+bzhLKVUzKNSHuM88vzyHuvncnMom4qg2JzTsTnDmi63
         ITA97b4sJisitirgavV29zjKDjmikFBEBx6ER1oRzP+rCfKkElVm/WX+wWC392wC4XSI
         qbIemzC4rWCSaB20d0zB6M8HTRNAqTk/vggCBsxBUmsl+gsiSGFtN1k9JG8DUs+DO4g7
         W636a46q58UsNcXuVcFOhhLhYMspxqBkrGc9uiqMBQP47X9LxVTclSHyrZly+d0ii1Zt
         74CCwRbvuWFcH+2drGHoo6XbaIGtruwi6jrZFB+y66a0pb9Wb0e+c1j9IawnlOItQ9Sl
         u/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764871252; x=1765476052;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wrUOSAWKU2+4eHuw0PQplu30ZrAwFfNGX6rR7EKHuPk=;
        b=OulyYFu9a2TKnUftjYzCjUUFwoQv2LrsQqIDqlzwft7NC6jCX8cUXFwGYTtyUBGqkX
         72m6jGIcD8xlPzxrIfxxIOW/rt5WRYWmfKgngvN2/Gu6o4n270ef1jfKFzCfXVvSqzZx
         /6FNISPTDMe01pTSi4V/6kl7MxAM8sZc016RNzlHIfmN0zIev9Xa9HKAzU5Aba5B4/D1
         cjxRpy7woqMTSyTyZ9UIUU1gpdSY80h8GtW54qUN2HJFs03Zk04mRkRIwU2dgIWKbgGV
         1OdEIGPzgQ1KzPt5bP7PUXILtz89ILgjARLAQINXj3Eo3TyZGgvv1MjC6yYXlj762tsg
         b9qw==
X-Forwarded-Encrypted: i=1; AJvYcCWYo9z9kIEqQeYJmxBXaDLn6theESc4R1chRmUdbfmZcsZrYgIgtHV8Bo0oE13+nhX98J7Yq/6B+wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxatAjxXPafFuk3fvNC/GmD5Fpu/biwC5KuDJIxyZZtKZW5HCVe
	Z1MVj4IpDxYKA4pnahiC+iv8IHFSYO9tEU0SzbzPdT3RJrsNzpfISY3Y
X-Gm-Gg: ASbGncuspgZ+PYMLcXZ4kk8ovWNqRCRs2MTEv1vur+50RpgV9EddDBeQN+j0KU5tLjb
	z7BFMMDPjNOuOG0p8LxaEu5Lp+w7xRmxykUPeftAqVCJInXxwljPMYVbfsdLUAGvVN7APookYm8
	mGZNhtpmKoook3dixexCn6ZTdTVR/PRxWYuY+ESiPldzx6OllxeJtkapHmEaJ5W5x9ddFyEPGDW
	C5YR1hvvrrv1uaoO3AzosdKtvPMBwUlmjyExt9LmFeT5WPKYzM2FfHzv6vdEcA09jxSAbXwzQSq
	YUizHDnzw0u5+4t6Iv4R3rZgwW9+CWGFj7j3KuJ6buwSMWmb5ZGpQHjnCLpVtT29Kw3b3dzRps8
	y7nKoPtbPBQDO2FY2N8uvxKG60GZY32NDK2Rgzf3wGMq3b1R/+K2bdVcg+jODufHW+c+JVIkoVl
	O17tGnDw==
X-Google-Smtp-Source: AGHT+IExPtnd5d3U703GNk29/3hRif4bhRG/9nZEy+8B3PyMEvej6G9sES9up6D5q/a46Q3F6FE8jA==
X-Received: by 2002:a05:690e:2459:b0:641:f5bc:6987 with SMTP id 956f58d0204a3-6443704c428mr4785425d50.83.1764871251874;
        Thu, 04 Dec 2025 10:00:51 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b7a72dcsm7751637b3.52.2025.12.04.10.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 10:00:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 13:00:48 -0500
Message-Id: <DEPMN6QFWRY9.21N6RX5DMVEHN@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Kurt Borja" <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Tobias
 Sperling" <tobias.sperling@softing.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/2] iio: Add support for TI ADS1X18 ADCs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251204-ads1x18-v5-0-b6243de766d1@gmail.com>
In-Reply-To: <20251204-ads1x18-v5-0-b6243de766d1@gmail.com>

On Thu Dec 4, 2025 at 12:55 PM -05, Kurt Borja wrote:
> Hi,
>
> This series adds a new driver for TI ADS1X18 SPI devices.
>
> This is my first time contributing to the IIO subsystem and making
> dt-bindings documentation, so (don't) go easy on me :p.
>
> As explained in Patch 2 changelog, the DRDY interrupt line is shared
> with the MOSI pin. This awkward quirk is also found on some Analog
> Devices sigma-delta SPI ADCs, so the interrupt and trigger design is
> inspired by those.
>
> Thank you in advance for your reviews.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Ah - I sent this by mistake without making any changes.

Apologies for the noise :(. I will send the correct version as v6.


--=20
 ~ Kurt

