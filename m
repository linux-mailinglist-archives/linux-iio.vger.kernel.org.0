Return-Path: <linux-iio+bounces-10386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F6F9986BA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 14:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74FF1C23CAA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27EA1C6F4B;
	Thu, 10 Oct 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+G4yTfU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAC51C2DAA;
	Thu, 10 Oct 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564909; cv=none; b=SLpqy+uHPJAlgcC6LU7eYUcc0bKU/QTjy9rnuXZBfCs9S7tzAZCUeK3185d5Ke0/flOjABJ5HhvVJpbXYKMvqayWsmM4c4uM/+2EZDzjAZE2AlsK2cL4u6nDaTdn0radIjj7613uazwnq0JHEj4khI3tlhcR9chufLWcURDi+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564909; c=relaxed/simple;
	bh=c5YOO3PqT5p0RhvzjAME/TqZqQtmmFNIrX2KOAxy+g0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5v6Fx7UwuKFpaKTOlqiVgoBa9DupTBrgzNR/qIoh2piAVF5H+QxuDcC1lKbPO1bMk+f18YRUjSVCSmWmN/AmBJF9rLdf30bhVqrpJPkXzBzDAPo/KZm/bnxfUAWwjI+z7ENB6i2Vq21X16TJ69NvfnO2czedBELWDBsT6o8LKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+G4yTfU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-430576ff251so7708535e9.0;
        Thu, 10 Oct 2024 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728564906; x=1729169706; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5YOO3PqT5p0RhvzjAME/TqZqQtmmFNIrX2KOAxy+g0=;
        b=Q+G4yTfUzrDJC4mn9PRA6MWStx4PEG7NOr+/w+k40mM9XiX6sbtb2xpwQ4efXvsSi/
         MWEWwUCoWHxMp3vhPf1kQnGvM3LScKvanmphFDf4KTkOWYU9/hXb6vzqwel5tOsMdpbN
         tmD3H8dSrkz3YvTIQ9i6Vjqqamg0jssuS/SQ76+Aj2BioFcIv4An2wXGiqnRya93Ky2e
         h3jBETLp5r4/TRLSreouDAJeRwIxkvN7+1YRAFBKOFqWxbm0G0mXKHHcP9gaLyMHRRhT
         VfA71GUrBqf8sDKZ1kEG9CWZTbS0wN7r166XCCv7dQuQtklBzg4cHxI1QL/J3tdFjBRl
         PyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564906; x=1729169706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5YOO3PqT5p0RhvzjAME/TqZqQtmmFNIrX2KOAxy+g0=;
        b=itj79WnyKsV6hNP1XCM02ucSl6LAki+W2rWtpr6jQJkOQ5ed/HFhkY61kMMggay9om
         ohRWh8tyHc9t+pgJi9WeXMJujlHKMATBYjxZXAy/uN1NU17Is1Z3xLcMXepA0arRjIEh
         CiJMnb+nmBdLnZWabXSjPtxCIUspFBv4OAgKyu7SP35Bj7089CktRwr1Woktm/sqbTKg
         u3hrYVml/VYUfKXlJDdXvZ9JBpmpMLdI4QEumYcjJqE7wAEeKm4YHnYiC0ma8tEevUXY
         HWOo4fjxnsXI0QvrICNi8AWcJdTCbeLA8HQU/d6C7FobaLM4W9BMEQ6dtZYEgD5MukrY
         845w==
X-Forwarded-Encrypted: i=1; AJvYcCU1TdIQovNZaDH/1zk37T+xoV7HZzePJj9diq3HmCyU0zkrTKZq2mzLw8i0QWSqtHleYn7zdEoIJKrK@vger.kernel.org, AJvYcCVlMr7EoX7alaVh7eMK9Zo7NZoUnNM+vQG0n9TZp5qDk74fyL5BMt05ZGJEiHvhatmaNneKae2tU5YH@vger.kernel.org, AJvYcCWeyzIBGHle+cQ+ws2ZmgTA41fJ96Fr1wwUi4s79g+SO2gC8ZVvxodlNe4g6P/QBZfEqOzdEcaBOA3yt8SO@vger.kernel.org
X-Gm-Message-State: AOJu0YzXTurkH0iLtI5Tfs+vUKz9aSG4fs/p/7FyfIfdznYwXmhqOUOt
	O/xU8yfX7LArC/jVOHQJLaBhYyMvugv/Sj9nodxRTj3H0th1gtAM
X-Google-Smtp-Source: AGHT+IE9zk6J9pnKB3CrkToVJ8ktrG3arNVRbl5nS+RDZhg9k9AhczWUhaGj2N32N9CY+aLIxzvbqA==
X-Received: by 2002:a05:600c:510a:b0:42c:b843:792b with SMTP id 5b1f17b1804b1-431157a3ba3mr30752595e9.2.1728564906184;
        Thu, 10 Oct 2024 05:55:06 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ed69dsm1486749f8f.92.2024.10.10.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:55:05 -0700 (PDT)
Message-ID: <a02f256c54089da4faa3ee1807c01b9cb6e70bc6.camel@gmail.com>
Subject: Re: [PATCH v5 02/10] iio: dac: adi-axi-dac: update register names
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dletchner@baylibre.com,  Mark Brown
 <broonie@kernel.org>
Date: Thu, 10 Oct 2024 14:59:21 +0200
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-2-3d410944a63d@baylibre.com>
References: 
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	 <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-2-3d410944a63d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 17:43 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Non functional, readability change.
>=20
> Update register names so that register bitfields can be more easily
> linked to the register name.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

I don't fully agree that this is so much better that's worth the churn...

From a quick a look I saw (I think) some defines where _REG seems to be mis=
sing.
Those is fine to change for consistency but I don't really seeing the big
benefit in changing them all.

(Sorry for only complaining in v5 about this...)

- Nuno S=C3=A1



