Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A201418EC08
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 20:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgCVTxI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 15:53:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34207 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgCVTxI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 15:53:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id t3so6053594pgn.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 12:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=J/841JuvCeA53RZ8dJXKpt1uGhDH+Vva83ItLHx0E8w=;
        b=S2OAnJqE2XEFXo+9v8HxtNKphSgU625kheUFLaMTwdbTBV66YzTkdY1MDrQYFhK3mI
         64d4dBsCQge9cS6PV/5MkS5qmPyD7vXLPKuKEGJCwTkzcrHCZ2E6v3WrEV6BkvoTb2gy
         BHr3NJfSgbZ2Hs/p6FKTUpmwjVJE9V+VIeSe+w0q0cCVnWfWzjEI0R+jQrcYDrfEjr1t
         OLX/xftpol7+m90/3HjWbIc0JaTKVrpQ/EKmjZs1asROSLom0/rf5gzOFryIyo7sNVu+
         kLJorDbRxddWYPh59Xw7Jq8NvzMJDaXLpPD4wePgV77bKzYxQK07y3okd2z32vcT7t6H
         05Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J/841JuvCeA53RZ8dJXKpt1uGhDH+Vva83ItLHx0E8w=;
        b=tWcyA3sTss3hAEjbDwyyLua7eP5ci8Es/PmPy0+W0DzqXNJs5zNlxDWvEgN+JIa9Ze
         ycSMH7awUL7JB3qov02c2yoR4MG8laN9AGP2/+EOB8WTbAUi3AaQlOebD4WiK8Ftgqlw
         t/E7kyElg87WvMExFVAq7mdprM5cxz/RV+t6Qz0TFOPnyT6VQKFu8gEgTM/G00eSuhnJ
         uCINxlM5UyvjSQc118EdD9JTAZEIQCgTjl1DU2Mn5pRfDNlspfPNgoF5lHJGqu0ZuQY/
         9Omzg2ien7Ky+3F1iO88pZxpa6B77Cq3Ozdk/5BFWUKzuaLXGsryaa7+f6LXRNjn5my7
         JHlg==
X-Gm-Message-State: ANhLgQ2WIAJgSOYGoeB0SZCwDzTBq9m0QXspSTbDTTJchPurElE2cujM
        l9LPwuGlmUxdkmXvuSsETio=
X-Google-Smtp-Source: ADFU+vsiSNXgH13Sh83un2FDx1VAQhzHLF/Eb+G4TfS8RUDHlzVkmufAgXc8Db/k3i+owcB3MRAzxg==
X-Received: by 2002:a63:4641:: with SMTP id v1mr18310060pgk.156.1584906786215;
        Sun, 22 Mar 2020 12:53:06 -0700 (PDT)
Received: from deeUbuntu ([103.240.207.191])
        by smtp.gmail.com with ESMTPSA id q185sm10650767pfb.154.2020.03.22.12.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 12:53:05 -0700 (PDT)
Date:   Mon, 23 Mar 2020 01:23:00 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 0/4] staging: iio: adc: General code reformatting /
 cleanup patchset
Message-ID: <cover.1584904896.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Address code formatting warnings and check messages flagged by
checkpatch script. Includes improvement for correcting macro
name typos and simplified function implementation. Changes 
intended to improve readability of code.

Changes since v2:
	1. Add new patch to the series for ad7280a driver to add
	   comments near code that flags a misleading checkpatch
	   warning.
	2. Add patch version number v3 in individual patch subject 
	   lines.
	3. Simplified current implementation of function get_filter_freq
	   per advice from Stefano.

Changes since v1:
        1. Add separate patch for code re-indentation comment
        2. Add separate patch for correcting macro names as suggested by
           Lars-Peter.
        3. Update variable name from sync* to sinc* as suggested by
           Stefano.
        4. Revert patch intended to add space around "-" operator. It
           was a string with a "-" sign further formatted using
           stringification. That patch is out of the patchset now.


Deepak R Varma (4):
  staging: iio: adc: ad7192: Re-indent enum labels
  staging: iio: adc: ad7192: Correct macro names from SYNC to SINC
  staging: iio: adc: ad7192: get_filter_freq code optimization
  staging: iio: adc: ad7280a: Add comments to clarify stringified
    arguments

 drivers/iio/adc/ad7192.c          | 37 +++++++++++++------------------
 drivers/staging/iio/adc/ad7280a.c |  4 ++++
 2 files changed, 20 insertions(+), 21 deletions(-)

-- 
2.17.1

