Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73405AD332
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfIIGmV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 02:42:21 -0400
Received: from first.geanix.com ([116.203.34.67]:42758 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfIIGmV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 02:42:21 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 5D28A62826;
        Mon,  9 Sep 2019 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568011312; bh=gec7ILZJ5aS8kit+qPbRly+7P7FUDHqFqWstMP/YpCg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bFwZccQT8crvMwplIcomAhFNHS1eC3c1ie9F9SMJ90LVL3v+rqeei8w46tUkpJSk1
         CNJqzmIaEFBAVfvedCLkaUSnwA1A6CTZigcO/OQ1LvzMIh/1DpuyIoio0BDUpnXkLX
         dKsNO9i4mIBoyu6I6V0sREc9Q7jhrvXIpmUvn+OsDOiOTG7OfQHcbMjuLkvOHRr5Kz
         jnkLEqoq7s5SaA/VsNcvSkJq/rFmgbDKlzy0Xm5udIv/8vQuohIjGBwWVkTzFMO/NX
         gh6J+BLFa8qhjI8U2oQ0EzmgLDsyxIbVUJgnm+GjqZYEQtLEzS5b5UCpSjYA72lO0L
         oZ79GsJTSI96A==
Subject: Re: [PATCH v4 2/6] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190906121716.66194-1-sean@geanix.com>
 <20190906121716.66194-2-sean@geanix.com>
 <20190906140238.GB4515@localhost.localdomain>
 <20190906141330.GD4515@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <5cb1163d-756e-4b2b-efe9-3c27bf6dd946@geanix.com>
Date:   Mon, 9 Sep 2019 08:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190906141330.GD4515@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 06/09/2019 16.13, Lorenzo Bianconi wrote:
>>> +int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
>>> +{
>>> +	int err;
>>> +	u8 enable = 0;
> here you do something like:
> 
> 	if (!hw->settings->event_settings.enable_reg.addr)
> 		return -ENOSUPP;
> 

Here we need to do something else the LSM6DS3 doesn't feature this 
enable register.
My best guess it's enough to enable the routing of the interrupt in the 
MD register

/Sean
