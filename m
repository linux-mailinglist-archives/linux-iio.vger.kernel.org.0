Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB56CDF1D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfJGKWL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 06:22:11 -0400
Received: from first.geanix.com ([116.203.34.67]:53992 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGKWL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 06:22:11 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 696505089E;
        Mon,  7 Oct 2019 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1570443648; bh=Jh4j34suQivad3Lpsk/28/svQJUIiUTYBK5ZLnJ6/Gw=;
        h=To:Cc:From:Subject:Date;
        b=PsQDmCf8Gdp2r/xCYQbAR+1zWKmmtzC7525LkaJrPAQQof/JtXy7Wjv1us0gCLKUu
         upNV/iRrIfQfC7cqSsNnSTb+avVEU0tI4JJGEAZHx3LkyN3Ej1O3wF5Ty4+rw4UJt2
         7lOfTTH6Umt6STSDQQNViHCjD81k80lzjiDPD/D+7WI+9yeI2KdqmRBP/m1WkbVUrF
         lckVedrcKu6EcDgmiPjJ4yup8gAF0E1I7qYQ2tfAvPecRV0Vz58bji66xLFx1UKef5
         NlCvg8dJSfAiwgS/mC4RpoR00LL9YGx+1sLULi/LQFAL0dpJn3s9COcxWK93R6ZS7f
         scCjSVO1OMdzA==
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Subject: [BUG] iio: imu: st_lsm6dsx: read error when resuming from suspend
Message-ID: <128e9528-593f-271b-708f-ef197c08f3bb@geanix.com>
Date:   Mon, 7 Oct 2019 12:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=disabled
        version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b8b5098bc1bc
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lorenzo,

I'm seeing this error sometimes when resuming:
st_lsm6dsx_i2c 1-006a: failed to read fifo status (err=-13)

I doesn't matter if it's the ism330 or another wake source.
I have not enabled fifo readings.

I have tried the "[PATCH 00/13] various st_lsm6dsx fixes and missing 
bits​" same results.

The regmap_read in st_lsm6dsx_handler_thread for the event seems to be 
reading something as the event is reported correctly.

Later events are reported correctly...

/Sean
