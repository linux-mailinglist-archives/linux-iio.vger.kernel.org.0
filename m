Return-Path: <linux-iio+bounces-17510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50698A77BD4
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030B43A5DA6
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03431FDE31;
	Tue,  1 Apr 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btpANBNH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90961F930
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513264; cv=none; b=lf5h8vkhxLMyL4m2lbAr8GCGqW1aVLQNkhNPWlP0Vc5l8gsdnm6q68YNMN/OnLALShwjJHqzFe2XmsOal7YBLEhsdHUNEZNlU0HzbF/ZDgnAnICyO02EWTFDcf3ykAn1eLZMmq+dgOl960q7ZhbPOZ1ol2JOoqf9cSboXxAsGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513264; c=relaxed/simple;
	bh=zFWH1/qE0lkhccicxDYPyPQ7TBKgaiivO7XgPBstm88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4R7hEqNmSD9mGeMuUk/vcO2vd0YeSN5mRrRuNTrYELMzwYlXUANxFIBcqTYPld4b18DYsCyxKoew7Ml4uimqAluaNaSpgt3+AMobNQo6uWGWa48/OAsF6N8cc8+bYhT6AcG1STQLuPuh+4Uus1WOqVQzpA5Q3j1ahNpUY+H0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btpANBNH; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54c090fc7adso1181140e87.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 06:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743513261; x=1744118061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMfx+wEbpH99G9oEqO/3BKuSPiO5siE+XkVWhD7HQXg=;
        b=btpANBNHAQypKmpDntLN5dVtZW7/KRJoIlO7l9M2XIif78nEivDOWuGX+Qv1JVf8na
         OSLLW7SzqaazKrf3UrsIDz81qDretnad5v4Ye8G5OVs4/fW1Wf9khnE7rHgE/HJ9QO9I
         KdeO0MHN3Q6ZTGtRlLzbuiIco0yxNT6WH0aoNmN4e6MyUORYlGhjZNnYpRwxK4LrBdgY
         xx76Tglevz5MYIKNV5qZCbVPHE6i0IEOEZH42VSE0QYh5eNpGWQuG1ocBIMD4YPQzBbt
         QR2QMzxS9zh7M1cf1ziious7t7UaUFkYhEjo19byvDRxPH/xf2EeMtRgOOJ+dadLsTqs
         ZFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743513261; x=1744118061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMfx+wEbpH99G9oEqO/3BKuSPiO5siE+XkVWhD7HQXg=;
        b=AmvJCQabvtBnuyJKEyiwWobodwrNplQ0Da/duryueTM50luKkJAuI2vAgOwvnjFfs3
         6jIA/3GcaNnFe8CuX1EPqdwQFnyfIBrq8kZ1l6r4KLbaZ/o3PswJSKiVYJQJGDSLVokp
         oPLj9+X1ER5qDNWAqjWhBlp/CODaDozh++KyhFPK7r+7nXe3Tvc4uNjr3HG9p39j0qdm
         CPV3WPEGQr7etx23Xvx+3Z+rcTIySrYECaj7lO5Ci8Xgh/BLLsaclZ0pby8F6Wdl3OCk
         PmVj2hlTysJvYYCO4aFGrZl24xS6g/y2kqHJ00wRBGiuzu3gTnyLpWf7bGeorFkOwgBS
         Vmvw==
X-Forwarded-Encrypted: i=1; AJvYcCXPDwN4YThDYfnhQyQaopnJeH/T3Cwts9JF0QtryNf0X9J/3HZDQ5svmyIILn8JT7g0t07cVQNH/2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHf0TITlxnuqs60PF4gnl+GqYqtQ7+VUesf+HNMj6araPFL4PO
	LAY41elIKupmHmGdasfUDjX10iF1FHw5Ojow/8dnJmBc2cIrmmht
X-Gm-Gg: ASbGncvbAsYZ9r4HyJzpqsMQdZBV7x5xA55+H5clcXSqJvvflAT5pB9TOqpbKpJIOFY
	KOy50DQ1MBMstgcJqtnwJOWMAHpy+dvkFTcVD9KJPc8/o0ZcnvNPQm7TdKQBAQmqY2Mt2V3KOM9
	njZVwDVFu6Naid9OR7+urD+PHS2bqZEmNKdOWpErbrHqYbq6PaoG3nnX2RblkRj4dSuhit5NkXJ
	3TVI/S7Ki8w88MdDKQPTtf+dPZyv3E6Aj6KVMxSGhonvSEYitbH+VJ8QCMSCFOodfGgtd/ebadG
	EaS36S+Apbw1KFjYFIHcc01D+y+GSKEG4lNBf77RLGl92iXMNYNiZxv0DSB4ii//Jgu1x9Xuc/M
	d5QcAzBOEfHPDICvsmt3IlKihcw==
X-Google-Smtp-Source: AGHT+IHcE50F0SjSszqE4loXUy76loTnTqeGYu9cNVJBv8qHk7LXnuTX/9NSn2L+BjOlcGsFII5Lkg==
X-Received: by 2002:ac2:4c46:0:b0:54b:117c:a06d with SMTP id 2adb3069b0e04-54b117ca147mr3223627e87.54.1743513260496;
        Tue, 01 Apr 2025 06:14:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09590fffsm1366031e87.167.2025.04.01.06.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 06:14:19 -0700 (PDT)
Message-ID: <cb8149f7-63fc-458f-bb26-49cbdb3a88da@gmail.com>
Date: Tue, 1 Apr 2025 16:14:18 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/37] iio: pressure: rohm-bm1390: Switch to sparse
 friendly iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Cosmin Tanislav <demonsingur@gmail.com>,
 Roan van Dijk <roan@protonic.nl>, Jyoti Bhayana <jbhayana@google.com>,
 Nishant Malpani <nish.malpani25@gmail.com>,
 Eugene Zaikonnikov <ez@norphonic.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Shen Jianping <Jianping.Shen@de.bosch.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Yasin Lee <yasin.lee.x@gmail.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-30-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250331121317.1694135-30-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/03/2025 15:13, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti

