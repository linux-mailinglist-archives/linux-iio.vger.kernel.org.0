Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B894B21B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2019 08:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfFSGa2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jun 2019 02:30:28 -0400
Received: from first.geanix.com ([116.203.34.67]:48468 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfFSGa2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Jun 2019 02:30:28 -0400
Received: from [192.168.100.94] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id D2E4B345;
        Wed, 19 Jun 2019 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560925824; bh=rPfLhxJi+2oIXAvcokkMlTvFUL7qeGTImf480mmZF5I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hOtu1/GKc3KbKI50yKkkbDu3qr96D2OWh45g+NWWs5oY+OnEd/WKnqPHSDfLcwpL5
         wRtYxIjHOHZbGhhqqI2mdPqLI8oGxGQzIkgGYWaGpXGsCHFdsxvELysfzT4SoAB5oD
         ztmQVzdNvG9bD9aCDdJF/GoyMdJRzv9OD17K+wFo4qMtY8dbSSj2XxqfzaJu3v94B1
         syvTKgE51BrixEu0awV0qLeLsFhZ0LcISH6EzRwbA3KvPZitG8bu+Czzwchq5LhKKx
         7SiC6cLeNv/w3AG1VcaWUE75yPMC9vUdeUkq/tvszVbUhomul946i9OTf0Xqkq+4YP
         vBuyTIBxpHqwQ==
Subject: Re: [PATCH 2/5] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-3-sean@geanix.com>
 <20190618154928.GB20044@localhost.localdomain>
 <e41ada28-a8b5-2911-7dd0-d8833debdcee@geanix.com>
 <20190618202142.GA930@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <a6234f3d-9994-cc62-6365-39b43af3d196@geanix.com>
Date:   Wed, 19 Jun 2019 08:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618202142.GA930@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 884f5ce5917a
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 18/06/2019 22.21, Lorenzo Bianconi wrote:

>>>
>>> Could you please verify this registermap is used for all supported devices?
>>> (e.g. LSM6DS3 or LSM6DS3H)
>>
>> They have the same registers and the bits meaning the same.
>> But I can't test on those devices...
> 
> I do think so since BIT(7) of 0x58 TAP_CFG in LSM6DS3/LSM6DS3H is used to
> enable hw timestamp...moreover I think there are other differences
> 

The LSM6DS3/LSM6DS3H have the inactivity function enable in
WAKE_UP_THS 0x5B, BIT(6), ISM330 have that in TAP_CFG 0x58.
The rest of the WAKE_UP_THS have the same register layout

WAKE_UP_SRC 0x1B have the same register layout

MD1_CFG 0x5E have the same register layout

/Sean
