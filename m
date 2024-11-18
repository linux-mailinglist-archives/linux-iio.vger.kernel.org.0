Return-Path: <linux-iio+bounces-12369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE6F9D0DEA
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 11:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E44282D7B
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0ED1946CD;
	Mon, 18 Nov 2024 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XMNzrBc6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A3193432;
	Mon, 18 Nov 2024 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924635; cv=none; b=YN4gzLW14JyadXo6WH3XCvu8Fp1ofYZVAHy79lonmfsxD1bQeSgR/fwTqpY70TuIMoxFzJNHaLpdr7taMxrwsmQHYoyQcDfYCculcH7bvK5u+6tJ+1H2IPZvbGqrV22sPRkE64yyxnWFvL/9dfPjio+ievLZ0Cj3yv8q2kpLQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924635; c=relaxed/simple;
	bh=G8RQyr4OGxhyplbDi80Z0G0RmfHSLulpn812PX1WlAc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LBtMeE+bnl7TfHG+eC+OTh6sPIDNdA36kjoRnF9hiB2b1KfPs7+coeq/GY6eW/srHZP5fJz8InSbIoEN7hnkbKoMKNpN9m0jwWonllE45d/WFT47MmWOqQqgZDOEszQFJ4HKG4ZvGPt1BoifE/jAlwYFmLOUPBsSkExljiM0ubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XMNzrBc6; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731924583; x=1732529383; i=markus.elfring@web.de;
	bh=G8RQyr4OGxhyplbDi80Z0G0RmfHSLulpn812PX1WlAc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XMNzrBc69JsaS3A2HwQJqxGxEOQFRsXHa+IHJlbtOVdCP5laTW3vUUtMp+clDsC2
	 6jkAZvE9jyot/l4SnJZKFICpk29Xpe+FKduA7KaL8HsITzuoT0/wH5nZ/hQKwMAxF
	 XvTZLg6kav0pKK3X7/q7HMzpVSmwEbjCTlW4fe6kP3Xwkgldu27vleHCiScUO4ULN
	 r53bR8sTueuQuZ9GwJFu6W4rD6karH3FskK+TauVaUVK5s11LLSJ5nOnDWtUiJ7zW
	 HESXdcbeguxPJzRYR2NDVNHil7+WwIgnz1IHPMrC09+qVjA9YP+Of8gwiF9dOGBK+
	 Ce8G8JotJ3izFEzeDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqPT-1tYrFW25NR-00kmc9; Mon, 18
 Nov 2024 11:09:43 +0100
Message-ID: <ba5e2b95-12d9-490b-b58d-131dedba6446@web.de>
Date: Mon, 18 Nov 2024 11:08:47 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Charles Han <hanchunchao@inspur.com>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241118090208.14586-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] iio: adc: ti-ads1298: Add NULL check in ads1298_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241118090208.14586-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BHgIA96HuK3bkxuoMLZH5eiWj1cl6oyGDaHp6pWh8DKisYvisct
 pYUWOz2K8iJ6QGH+5gRmUHshmIDB+H66Eg1PiWkrRckV3ftiBo4Ms/AdwVPUk00CpcJ4UlF
 eNAciiuYWH7VLbYB/rhPYRmDdM3BVMaIgl5SgNS0iRKYf4ExtOhz6JmxulxfZ5yjDsPDRPe
 6sbREXE3Z5D2VSteSpdjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W0Z3npiPk9g=;Wv4s8NTLtXqx+SdhbG7dAFW84Cl
 qx91KCXc8aLcQ8QXXcQ98IK/3iQ/2NMYvEv06J0s864hlX1cCpgrlV3ZzvwveM8KyfGulqsdP
 NsjI+23Q6hg57pDVLtIgLzW31kCR4FZLpJ04J0eHrnbfZT3qZNB/RPcTW2ziz2g2n/N+szOR+
 RKe3yeJrhlOhp9q7AeB4qFg7VS0BmNsHkD+Oplz8Po+fFyDIVYQ97g/VRP3lU/tHW1rYEaGMu
 s1aMCH7d9MdwXtleD7hJTWmQKkyuoTUF5ditde8YccHwREeqKdSCvtzFlx99/m4B71WsVPzte
 YegjUYkxkQA1DDPVrLyAZ4GQ8hJ6qqgP8cSFHwOxbtC2pY7Nx7fKH8FSIRG2vPd96640yD1Tn
 ItY3aZmt+96WbppeTUoSO4r3TJARAucxOu2kEZ4ZyOv3EVCq/bKxNOpYPINfzY44Z2ZiLhgsm
 vO2LNvdMD+LFhYKdl4a3Qay/nh7S1S/DvMpd3r03Hr2yqtJVNc4c33LKN7h7YPRc9fpl8u9/E
 FacfX1PNnSLJj8CSWpVhiTa60d2hIwE+TgL4j31DGKiFot44FWwRXwS2QkzRE010O1IsUGIe3
 s8ceS18X7EHqWeRNDneqyg0luOXY8U8fUjwCkWnIrepBi9/rwRIpCWe/YZNeQ+depIOBv5WS4
 akmCZs2sbRsOzsd00dUnFcPOuEvXWDPIBfOGBgoVfRKNF4HEs8vwx/++eK8Xw/yrQlLkkuzED
 dUSDDZZvJGd0qITlbJih5imYY/uhxQz5DPD23o74AV6P5dlR9DEpxjjLkYIMGhePHKxJyV6wL
 gF3U8PSm+0afPhuAFtX43Yctz2BvGPP3Y96cDbQqyhew3T5owEU082xCU9E0U33QAPas9uVdP
 N75i3zXopUAza11w1aaZTUGIae3rg+rej5i16U3ZWnuN6eTjN5PAYBaV/

> devm_kasprintf() can return a NULL pointer on failure,but this
> returned value in ads1298_init() is not checked.
> Add NULL check in ads1298_init(), to handle kernel NULL
> pointer dereference error.

Another wording suggestion:
A devm_kasprintf() call can return a null pointer on failure.
But such a return value was not checked in this function implementation.
Thus add a corresponding check so that a null pointer dereference
will be avoided.


Regards,
Markus

