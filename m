Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4749A9B01
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 09:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbfIEHCI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 03:02:08 -0400
Received: from first.geanix.com ([116.203.34.67]:39274 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbfIEHCH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 03:02:07 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 57BBC6338D;
        Thu,  5 Sep 2019 07:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567666916; bh=Q1qUJokFFHNRDEfo3WxlutXlQpU1iMorkTkP0vWdxl8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=C5ZwTBKYMyyc4+SW3mKMUKPioaFg1sw4j3YYtW6BCr/hhf5sIOsEQOGHdrYNEaEwi
         QcjKAW3tbcjnM0A/kvwfvvkf9M7vUtWYAFmQa405qR1/w9vfZW55xVSx2fzrXxLYsL
         iQDxBw/NjNViQ60vGFxOqK3u2bYDre14LqwdRegVip97TTuU9wm/nC3JCrm4Ao2pXY
         m5iyu/J0K1NR0o0SmO3PCKxtEowNN4JrRfEasOefvSxEkmfHsdQTQkMHhD2nzdrhYk
         OPvyOOkoYZUlVicrS+9DFyAjOq3wOnQBBZMBMRWkwBSTXH5+G/XWaGGeG4lFJBQNhi
         EzCfJbpLlb4jA==
Subject: Re: [PATCH v3 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-5-sean@geanix.com>
 <20190905063959.GB31578@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <94ee1cde-7cd3-0184-a551-236191a28025@geanix.com>
Date:   Thu, 5 Sep 2019 09:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905063959.GB31578@localhost.localdomain>
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



On 05/09/2019 08.39, Lorenzo Bianconi wrote:
>> Should we include these new defines in device settings?
> nope if are the same for all available chips..have you double checked?
> 

lsm6ds3: yes
lsm6ds3h: yes
lsm6dsl: yes
lsm6dsm: yes
ism330dlc: yes :-)
lsm6dso: yes
asm330lhh: yes
lsm6dsox: yes
lsm6dsr: yes
lsm6ds3tr-c: yes
ism330dhcx: yes
lsm9ds1_imu: no it have a very different reg layout

I would a lot more confidence in patch/work if we only enable these 
events for the devices i actually can test... (The ISM330DLC)

/Sean
