Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1921889F4
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 17:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQQNt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 12:13:49 -0400
Received: from www381.your-server.de ([78.46.137.84]:45108 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQQNt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 12:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x2H936M1HMLS+K983L//AapUVuLSBPmjCsKxeFLo3dU=; b=i53ya7VNPcCTYfD7Sf7eOLpupi
        t5iciESIt3qb2SiIffCnQ3Mj/PkA/qtH1QL2LouEahKnXOnszS7LQAqbutjmrbvHaTiyOt5QgwPBu
        oYzzZkNc3QZmedwz81o1Hbh8ZhxMyhmTac1DKTD8jNnMFpzMH3UCrEqeb4JHLuqvEB15PAdgY+mfT
        SvbUIIkZndVMoZaDeZmVw9mtkapQT/EIaMZAC5nu59uTHs0oLSCGTh+6alAundwxR7ktstW1AgYXk
        VV1myghB4J9bKBgkw8ZC9wnRV5xP3c8wVO+WsV/FQjOQ+zEqwNQlNM7j07BJ9pzJImt2qPDl2lw99
        Lr9U8Gdw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEEqU-0006EX-RR; Tue, 17 Mar 2020 17:13:35 +0100
Received: from [93.104.105.202] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEEqU-000UBS-HG; Tue, 17 Mar 2020 17:13:34 +0100
Subject: Re: [PATCH v2 1/2] iio: adc: ad7291: convert to device tree
To:     Michael Auchter <michael.auchter@ni.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20200317135649.8876-1-michael.auchter@ni.com>
 <20200317145113.12413-1-michael.auchter@ni.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2ae255db-f57b-670b-cf40-9d7f0ae66fdd@metafoo.de>
Date:   Tue, 17 Mar 2020 17:13:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317145113.12413-1-michael.auchter@ni.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/20 3:51 PM, Michael Auchter wrote:
> There are no in-tree users of the platform data for this driver, so
> remove it and convert the driver to use device tree instead.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

