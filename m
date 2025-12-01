Return-Path: <linux-iio+bounces-26578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA0C95778
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 01:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0C63A1BE3
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302AA45948;
	Mon,  1 Dec 2025 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMAyTRDk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969892032D
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764549860; cv=none; b=dl+uTKVgk4bcE97dNvWmFuyN/3HVdKVuupSo/YvFdi1tAldbQ/I/fypFSHpy+KuHj8stOa693Uubr5LqzaKcoPl3od/aqtF7GORKXFhl+/UNVhCb09J3zjbxTJlQIwJGX+r71ToT0XQCEa9WITbcEz0alY28z2xf3Kl0Zw+MKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764549860; c=relaxed/simple;
	bh=WXei8faNKFRbZg/5TRBpJIVvZ5EV4z9whv3No2ypEdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQXpblebqQqk67x68FmrzgcNCe2z9vKmWBr2l9kjW5CZIgE7DzsgQA/fYF6jY7iw8cE4Jz6GYzhBzOZ6fY4zqZsrjbiImnh09FRH6cFAXJLV5iFsTXJBWmA1WqGQWrrj1nABnL466W8XD2zSpK2XZqz8cG8iQz+oz7oVbEEdnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMAyTRDk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso3013752b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 30 Nov 2025 16:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764549858; x=1765154658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=loQBrjsHTLWumic5XUfpbVeTUpVIR2+yqTrDotKERHY=;
        b=VMAyTRDkTdDDHtdDk4RvIQACnLWow6xl7MH2H36dKK8KcRjs26CRPye1lumSZgwL6I
         VTGz6RF0+FwxHBWWnMyBZKWSunE8wq9En8b9ot93uu9/STnPO6UwczSJRctdtAXTX9vL
         F8dWH8TkVQaWcnzBr1YeTYFeH8VECBVKZv1Hm129yd51Xep35Fm1zBzqnfWrEJ0G6dIe
         PGvs8ZECyoOFielqaC/LHyxhfDz4taMfYHaBCqf2/lNBCom6jLSiT1Zv3QJxaIlRJ57O
         V/0kqyo+zZBI9VK6axYWmMW4w2YYQJaIh14U8RcTcINsxYJl2imec5EAAn0TTocBbcqE
         +H9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764549858; x=1765154658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loQBrjsHTLWumic5XUfpbVeTUpVIR2+yqTrDotKERHY=;
        b=WSZN4Q+IQCc6NOWeJzE945mJbtRL2OSIm+Av83bG0oqz+mLHnHXEy+I9W1EB4yQGjJ
         Rm4I/EE2xGgTlNNJaNpqJ7kKNW3b76hAUVLXfnMSHJEaaRhh4IS3kHOxc8tf4nk+dW6N
         bZMoySmjRb1o7s8nej0hb3otaLq4HKh8piyVLA4if6LWGneCm+snkJCY0O+fMiF6nb/u
         6+9lbPVW3jqQy2GX5U0WfBtINNaMOQ76V8uafmh0EtFlET6BZZbX/Mf0xjv8H76yZy0H
         p3TPu4leNwzrBjcI/bNCUGvNqmz33VqBHRy7Y72PmGpqvZmEqDvaBExjYSd5k/DXqckT
         CN+w==
X-Forwarded-Encrypted: i=1; AJvYcCXppqeAGqzKCXuM625CgNxo61YNHLhy9qxd1QZsaLGqpo6jRfuZWlnMzywPT/GADvnXFh6cgoHu4m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGLq3mCeWjbReNhqYP11ce1hZLUA8vApjnR6nJyMVKU0sHtvO3
	vZBygE2CXLWqX3VK3+NBFyzX89j02MO2y9RWXfpUNurO+IWpWibsw/ib
X-Gm-Gg: ASbGncuo6HebslmhlrVk+bPBVxWPaSnadYkpchmWnZBDdnwfauJg7GZXftD6V0T7TXH
	tbh/l+jjJzQG73C3GoEjyXiDRnNomIhwjYOiVfsuRVnL3ZqmIYs8xGKi4ee/R7u2zcTfGm/dZRS
	cU1O6z6KxVUOcYciElgKv5Eq7BI2mZE2SShZ24xjgTkdBiS3Twfpsq3h1ljp56wqxdbq/H53Egu
	v8/PJZc+xxWVw7Vg2DFLEosofUbV4Gk+GSvDJ+ztSIPhsKQwGDWvPr8l9HKxfjNDJK5MZOXJj9r
	p+lc4ekSL/EL6V+qUT5Jxst7J+AFTac0CLMyJmrqDDUVDCY604dE8bLjx5Lkx+eJRS/6cj1bTEt
	fyTKy8rju+A3WG+ynICWWt1Sh2dTGTsGJ1I9YTtFCo6TzmnFlIwKjfxgfiUQbuwb4yLgqz10cjH
	5/19+vLtDkkp+IRr3lozb5AU4gtmSOIfd7S6/F+AyGZP/deZu+kUaMpPixmgRpnLdV
X-Google-Smtp-Source: AGHT+IFgJVWGW8YwKUU9Iny4M1dxzau1tG3wPCluSngGPGy5qUbx1lrl2uJNSMdXKWMj7Ocp4T1S4A==
X-Received: by 2002:a05:7022:20f:b0:11b:c2fd:3960 with SMTP id a92af1059eb24-11c9d85ff19mr19455932c88.28.1764549857774;
        Sun, 30 Nov 2025 16:44:17 -0800 (PST)
Received: from [192.168.68.63] (104-12-136-65.lightspeed.irvnca.sbcglobal.net. [104.12.136.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm51936663c88.6.2025.11.30.16.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 16:44:17 -0800 (PST)
Message-ID: <ff66f890-b405-4a81-9d8d-7d94fee68680@gmail.com>
Date: Sun, 30 Nov 2025 16:44:16 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] iio: accel: Prevent NULL pointer dereference in
 interrupt setup
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20251124-expressatt_nfc_accel_magn_light-v4-0-9c5686ad67e2@gmail.com>
 <20251124-expressatt_nfc_accel_magn_light-v4-5-9c5686ad67e2@gmail.com>
 <d3318386-2646-4f1c-ab4b-6ae3bc71e9bb@oss.qualcomm.com>
 <aSWPnRBRdPS8vnir@smile.fi.intel.com>
 <61e860e7-fc3b-49ad-bf6a-9745f205d52b@gmail.com>
 <c627fc05-6980-44bd-bdde-4750b3bafe2d@oss.qualcomm.com>
 <aSieijZt117wOh-6@smile.fi.intel.com>
Content-Language: en-US
From: Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <aSieijZt117wOh-6@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,


Seems like Linus Walleij encountered this as well, and the fix seems to 
have landed upstream:

https://lore.kernel.org/all/20251103-fix-bmc150-v2-1-0811592259df@linaro.org/


This patch no longer applies.


Thanks,

Rudraksha


