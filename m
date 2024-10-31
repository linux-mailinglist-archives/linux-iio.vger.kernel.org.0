Return-Path: <linux-iio+bounces-11694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF89B7C32
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 14:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449C91F2219A
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904119F124;
	Thu, 31 Oct 2024 13:54:30 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5819C56F;
	Thu, 31 Oct 2024 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382870; cv=none; b=EH3h6uoNozNsnjeGcUwjiwwdhfc8x/aqFoTCUCVa4DM+NeNgl9nQyTLqwmmF/OZE2TwpKV2A/Vy6vqccRVa6gg47PQhnEiR2XqXBgNNBWrgT7HYdQogQhfW9TXriepkiH4LYtY53BqZncOpmvK0lLBEyiU9N7/7NTc8uEGDBko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382870; c=relaxed/simple;
	bh=hJhqOrb9icJdn9+eoAEG23GR1NmmQfebcODBfmoq4AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T5FQOk4ilfzgulqjbvhprDHqfIIe8JBtLFsKTdMQohNguvRdPv75w7v/D918weeYvuPJOJaI26dBi1NJHjZ79pekaZvai2GONhez7epC1ViBQPU77UP4yfd4ZWPBanKS+fqlyeHoL4P18Fh67QTRWMb9thFmGIbaTIP+ou29vAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XfQQz4Wlgz1T9GQ;
	Thu, 31 Oct 2024 21:52:11 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id D61FD180103;
	Thu, 31 Oct 2024 21:54:23 +0800 (CST)
Received: from [10.67.109.114] (10.67.109.114) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 31 Oct 2024 21:54:23 +0800
Message-ID: <35e68dda-5c1d-4232-bb3e-8488366ddcc7@huawei.com>
Date: Thu, 31 Oct 2024 21:54:22 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad7923: Fix buffer overflow for tx_buf and
 ring_xfer
To: <jic23@kernel.org>, <noname.nuno@gmail.com>, <nuno.sa@analog.com>,
	<lars@metafoo.de>, <Michael.Hennerich@analog.com>, <djunho@gmail.com>,
	<alexandru.ardelean@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
References: <20241028142357.1032380-1-quzicheng@huawei.com>
 <20241029134637.2261336-1-quzicheng@huawei.com>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <20241029134637.2261336-1-quzicheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500009.china.huawei.com (7.185.36.209) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Gentle ping.

