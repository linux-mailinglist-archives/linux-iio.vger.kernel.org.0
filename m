Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92BD4AD942
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfIIMl6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 08:41:58 -0400
Received: from first.geanix.com ([116.203.34.67]:56898 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbfIIMl5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 08:41:57 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id CD51C2D7;
        Mon,  9 Sep 2019 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568032887; bh=RL0dQjuMveDUurXMU80u2N0FDbdunk6nf8TBXhnODy0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=W+/VOg0bFflpn69v5qxF3QIMK8Ed8z6v1VVlkY4ZWYDNZ00GhzUhkcMUA3NkKo3pJ
         gIvZkq+H4lO2pY6M/BmT5f+5DCa5FkF3LqevuvZaayUz8Y0nk7W3D32TNSmmiTZuVu
         FcntIU+FOkLowcooYCQE3xWQcj3nskB/lXbAmWQUosN+sIGulBrXjjKxLVZ5JcU7pJ
         /s02UyFV1uCb7mKFa2up/9feZRCk0JcQvh4PXpSu9hmh8fOP0H8SrklDRag8UlNAK6
         ILzpZrRp4voGLe+dmKUtv7rwMdDj5RTakGQNsguoduHZqcvSi6L0S1uh40g6y4SFPm
         VPuh6inGKJS1A==
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
 <20190909120546.GE2990@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <6e987a54-250c-c146-cff8-99fa33255f9b@geanix.com>
Date:   Mon, 9 Sep 2019 14:41:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909120546.GE2990@localhost.localdomain>
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



On 09/09/2019 14.05, Lorenzo Bianconi wrote:
>>   static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>>   {
>>   	return IRQ_WAKE_THREAD;
>> @@ -1668,6 +1726,18 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>>   {
>>   	struct st_lsm6dsx_hw *hw = private;
>>   	int count;
>> +	int data, err;
>> +
>> +	if (hw->enable_event) {
> 
> Maybe I understood the issue between the buffered reading and event generation.
> I guess it is a race here between when the device is generating the interrupt
> and when you set enable_event. I think there are two solutions:
> 1- trivial one: always read wakeup_src_reg
> 2- set hw->enable_event as first instruction in st_lsm6dsx_write_event_config()
> and roll back in case of error.
> 
> Could you please try that changes and double check if you are still able to
> trigger the issue?
> 

1. Without the last [PATCH v6 6/6] and this diff:

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c 
b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index bd5c7c65a519..b303459e0d31 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1728,7 +1728,6 @@ static irqreturn_t st_lsm6dsx_handler_thread(int 
irq, void *private)
         int count;
         int data, err;

-       if (hw->enable_event) {
                 err = regmap_read(hw->regmap,
 
hw->settings->event_settings.wakeup_src_reg,
                                   &data);
@@ -1737,7 +1736,6 @@ static irqreturn_t st_lsm6dsx_handler_thread(int 
irq, void *private)

                 if (data & 
hw->settings->event_settings.wakeup_src_status_mask)
                         st_lsm6dsx_report_motion_event(hw, data);
-       }

         mutex_lock(&hw->fifo_lock);
         count = hw->settings->fifo_ops.read_fifo(hw);

$ cd /sys/bus/iio/devices/iio:device2
$ echo 1 > events/in_accel_x_thresh_either_en
$ echo 1 > events/in_accel_x_thresh_either_value
$ echo 1 > scan_elements/in_accel_x_en
$ echo 1 > buffer/enable

FIFO interrupts ticking in... until I trigger the first event. :-(
The event is reported correctly. The interrupt pin is staying high.
The result is the same if I enable the FIFO first.
I don't think we have a race in the driver around this, to me it looks 
like something in the ism330 device should be cleared.
Could the device go into sleep or power down mode?

2. Seems like an okay idea, do you want this in v7?

/Sean
