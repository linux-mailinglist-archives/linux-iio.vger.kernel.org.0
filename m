Return-Path: <linux-iio+bounces-11693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D99B7C2E
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 14:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CD71C21315
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 13:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A619F47A;
	Thu, 31 Oct 2024 13:52:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DC19DF4A;
	Thu, 31 Oct 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382752; cv=none; b=N0n3sWOW6gHdKsdGuE4QaauJSjWmpq+KqATwHE2uI1sUXT0g4z0FhdcarmC/L3pb+8jfUeDr4CPuGVgyz8mgbSzr3iB7y/sKxPMb1jGgUvYZbWvpeD+IP6BI0m8lzmBwemFTPdt1O5/SNoMNR+mV4f0P4BIrEqoIZMHCK4jtRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382752; c=relaxed/simple;
	bh=hJhqOrb9icJdn9+eoAEG23GR1NmmQfebcODBfmoq4AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WmMZUgGkeUW4qwDF7bCNP9Qr0nZ464NU/ezClcB8VEUgxGXDNMXnx22FKjx6AJnDguXyfWR5zYIC3nXOLPxD2FrPV3xrA4ioSFN6rEH6BEgwgldZShEftVhXjCrYak70+cSOvRllbCX56Z4dxndfPVMRWJ2LwHylFaDwJk2mhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XfQNc1gGwz1T9SQ;
	Thu, 31 Oct 2024 21:50:08 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 74E23140417;
	Thu, 31 Oct 2024 21:52:20 +0800 (CST)
Received: from [10.67.109.114] (10.67.109.114) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 31 Oct 2024 21:52:19 +0800
Message-ID: <1e20e95e-00a8-4066-a0b0-e369e14711c7@huawei.com>
Date: Thu, 31 Oct 2024 21:52:19 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ad7780: fix division by zero in ad7780_write_raw()
To: <Michael.Hennerich@analog.com>, <renatogeh@gmail.com>, <lars@metafoo.de>,
	<jic23@kernel.org>, <giuliano.belinassi@usp.br>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>
References: <20241028142027.1032332-1-quzicheng@huawei.com>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <20241028142027.1032332-1-quzicheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500009.china.huawei.com (7.185.36.209) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Gentle ping.


