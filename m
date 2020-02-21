Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185C3167D0E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2020 13:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBUMDo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Feb 2020 07:03:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41897 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgBUMDo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Feb 2020 07:03:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so874223pgf.8
        for <linux-iio@vger.kernel.org>; Fri, 21 Feb 2020 04:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AS2jM1Jh1X/Q+Tdzhb4AWnVYCZ6l3tFqrOPBo+KrIc4=;
        b=m2nMYH8fSGRzs+G+TvvGtGqKEjiugq21rJivQ3wmf8E9NHnOtWpRwycamg7DqIlTYq
         3v7M9XMl5L2C2oeVe20+JjEd3+U7Jfl/9DshBTZEdYxD4XyZWp9K2AgM0nx9MFB9+m+Y
         fMV82ddvEWv9IMIv7hNQLEhcWufPK1xsaR14cqCongDV9w2g9EUM/9qtbDDrVTrFdlD5
         Nxnr7RSrzE871tuZIfjuuuMsjrOfXObOkGHMWaB2WNn38BxPPGX4PQuGhl5nTdO8U4U2
         ReNWzLid5Gy43xOh/jqX4lTxXVj0WEaM9hTskeHVCCHV+w9kxE31JUWOOGp7uo3GWTuU
         XKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AS2jM1Jh1X/Q+Tdzhb4AWnVYCZ6l3tFqrOPBo+KrIc4=;
        b=oBWnPf5kUeZQ9bie4y1J97fDY1bB5n7IiCYPxFnyxh9bdjDwf5RffnkFKqGZHWbreA
         aoNbhdZb84tffKQckl6mqesm1IoxG8fKorERsdDNq/DVw3sFc06HC9Fv/9LZB3/Dv9kn
         kXqEZaECnWzT4s8l160C+l+8OVzdy0615cw+vXekCfZ1KvtakB46dEEIX9Jwf9Q5Ecyu
         nJOdVLk0XFc7FL3Py4Tc2dH/wossTF0dqvhAuzavm6AT2nqIczzZnFaLS77aYofEjfZp
         sU8wRFKFbF5lp8f64K6yk3mMUw271UMFGLBFyAT6Hv9oJA5HYzns4lds3SnzCIkMQnNk
         YxfQ==
X-Gm-Message-State: APjAAAWjGdX4peRJhRTV0VPXNLR6ex6ecT/GVhNoZ1jMYwhulelVlbL6
        8V3NlmDh1KRWk3ONXLuNPyI=
X-Google-Smtp-Source: APXvYqz+xcD4D4CS8XuZYGnc7QwIAFz0DO44DJVtOuLZu2orVjzQfm3joqYArExSa0x8fjSpJs/2Ug==
X-Received: by 2002:aa7:9aa7:: with SMTP id x7mr35739997pfi.78.1582286623747;
        Fri, 21 Feb 2020 04:03:43 -0800 (PST)
Received: from SARKAR ([2401:4900:3318:e08e:cc6e:530d:bc5c:ad1e])
        by smtp.gmail.com with ESMTPSA id e18sm2784374pfm.24.2020.02.21.04.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 04:03:43 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:33:35 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     dragos.bogdan@analog.com
Cc:     linux-iio@vger.kernel.org, jic123@kernel.org
Subject: GSOC 2020 with IIO
Message-ID: <20200221120335.GA4296@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hey IIO!,
I am interested in working on the IIO subsystem for GSOC.
I have always been keen on writing code for the linux kernel.

Here are the reasons I think I would be a good fit for this task:
- I was part of a Satellite team in my college as a member of the 
Onboard Data Handling Subsystem (ODHS) We worked on various
microcontrollers like MSP430, STM32F2/F4 and sensors: MPU6050, HMC583.
- I have contributed a few small patches to the linux kernel and am
  familiar with the development cycle.[1],[2] and [3] 
- I am currently working on the Eudyptula challenge as a hobby and am
  halfway through it.

I would love to help with any tasks in the subsystem in the meantime.

Thanks,
Rohit

[1] : https://marc.info/?l=linux-kernel&m=154152860128914&w=2 and https://marc.info/?l=linux-driver-devel&m=156768975515975&w=2
[2] : https://marc.info/?l=linux-kernel&m=154158381210936&w=2
[3] : https://www.spinics.net/lists/linux-driver-devel/msg128998.html
