Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5251798B6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Mar 2020 20:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCDTLr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Mar 2020 14:11:47 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:39089 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDTLq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Mar 2020 14:11:46 -0500
Received: by mail-pf1-f176.google.com with SMTP id l7so1436318pff.6
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2020 11:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=i1CIjOmh6azTwi6pdTSYD4D4l9y4Gj1KrdvuvpGt6TA=;
        b=QgLs+Bs0z2dM2IQbz+9ejV9gpik3FUA8BGxdaNuY1YXN/R9/2iu+B+mQiXlLTnjWzp
         Cc++zcZbKpY4Fycm3RF0ac+9WdGDKTT+H+NIjQNa4g5d1HKhJ30PfWCLDY+ZEMBgCwtA
         zFuRl/Biz8bdP1l4HtMladaE/tBDF7xU/cws+n32yDCavE5wzOi54uxo61w1fg6pd52B
         U2vSWBVBcL7iG41uOsSxF3+7dFDZzqXIAoGLt1z3FdJNvEBctdr4hX8/xcRqacTQHvv5
         K/8OR1TFlcrWQ61VH7JV22FhJw5muG7WnuR/EIEF7U0MIkqG3a9foxRnBd8QXDNVxUdb
         2ioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=i1CIjOmh6azTwi6pdTSYD4D4l9y4Gj1KrdvuvpGt6TA=;
        b=D1hluocjY0LgJDK2iD3VWaRl5DSBcuKN1tmYO8VYctGzRcehTc+qLTk3Mq6WQXaSeN
         SDkeclkCEylvgr/+sKLt5D0BkLvSZzJ0DKzyDpoQzv4ST3+kZ9lRV4rqhw0TVaXmb5PR
         XwDvAW9uRMemxbUZPemV2Kt1s5AkuMXohnrG4Ciu4Rgprtr66GEIvlmlMp3xlpaZ1Fam
         9WXyOXyd432af+gYvu1B97wlTVlRCj24TEQWpxzn/T5unpz9mzJmak9HHFKRavCSsnEb
         JbT//ylooZvSmEH/tuzT0GfvpQkE5F/0JOU96czbNHEQCBysmCtpyCgwLoCdDxEL/Cnh
         MYXQ==
X-Gm-Message-State: ANhLgQ0LRwv2hrwUaBYzfN/AJ7YMW1dJYCZnqlz68TTnw3NvPtaVwyHP
        KN6BsbwA3vuRVCk7bKUNCsMJ5N6b
X-Google-Smtp-Source: ADFU+vsBWnFiJt3QUE0YbYpCC+lVMhXzksGhYqGeEDozYiuv609smvwQNnHOg7yw1DIis1COWvNUTg==
X-Received: by 2002:a62:c5c6:: with SMTP id j189mr4322253pfg.159.1583349103882;
        Wed, 04 Mar 2020 11:11:43 -0800 (PST)
Received: from [172.16.131.10] ([113.30.156.69])
        by smtp.gmail.com with ESMTPSA id e189sm24426479pfa.139.2020.03.04.11.11.42
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 11:11:43 -0800 (PST)
To:     linux-iio@vger.kernel.org
From:   Nishant Malpani <nish.malpani25@gmail.com>
Subject: [RFC] Open Source Contribution | GSoC 2020
Message-ID: <3bc4e978-3719-bbfc-2110-81601272a938@gmail.com>
Date:   Thu, 5 Mar 2020 00:41:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello, IIO!

This is Nishant Malpani, a fourth-year integrated Master's student, 
majoring in Electronics and Communications (ECE) engineering, at 
International Institute of Information Technology, Bangalore, India 
(IIIT-B).

Driven by my thirst to gain knowledge about the Linux kernel and its 
various subsystems, I would like to be a part of the IIO community and 
receive some insights on how to commence contributing.

Formally, I've done a course on 'Linux Device Driver Development' at my 
institute wherein I learnt about the various subsystems in the Linux 
kernel of which IIO was one of them. I learnt extensively about IIO 
Channels, Triggers, Buffers, Events etc. and further concluded by taking 
up MCP3008 ADC as a case-study. I'm familiar with the development 
process and initiated my contribution by submitting a naive patch [1] 
(although it does need an update). I've also invested some time 
completing IIO-related tasks listed on what seems like an outdated page 
[2]. I'm aware of the previous conversations undertaken in this mailing 
list [3] but I wasn't sure if somebody is already working on it. I'd be 
delighted to contribute to any of the open tasks!

Thank you all for your time.

With regards,
Nishant Malpani

[1] https://marc.info/?l=linux-driver-devel&m=158326078122615&w=2
[2] https://kernelnewbies.org/IIO_tasks
[3] https://marc.info/?l=linux-iio&m=158257639113000&w=2
