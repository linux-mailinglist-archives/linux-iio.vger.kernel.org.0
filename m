Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3181354D
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 00:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfECWNU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 May 2019 18:13:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40980 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfECWNU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 May 2019 18:13:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id c13so8508764qtn.8;
        Fri, 03 May 2019 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mfp4K2wyLqvou0VkORSKLnmjS+wOeVL0yi89FQp3u48=;
        b=hSCZ+yMsnu6RQDJMtD/li/6sNmzj+3PDUXLySbQREbxOPFMJNIBKxUH+8XmkesAbZu
         7/oSKnCn3jwK9xlX/HYITipnFGs/nmb8T0OVTMlUe+lBqg8r8cQZ97NGgYBXe8vU0Uys
         2DpqeU9/KEQ0+EJnXLPQOHZlaQtcUMd3WuDbCdFPkjyXlAc+QaVFEW0o8UTN9LGBiRAA
         PfM9apyQr2JTonNA+oyBCwJZgr38gwtOy7HMclS12iLYwcTObQYvE2CQYXkuv7qhRbCY
         IuEWBv/12BxYlWkxGaWfuAkAkrDFUeI52iU3BtNEbJBBfAao9dAfE7EbUwm6v9LUN8xp
         Ns3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mfp4K2wyLqvou0VkORSKLnmjS+wOeVL0yi89FQp3u48=;
        b=U8zocwrsfUWD590vJL5VInOyLbNl7neE87D4DV44Y78KSLTlORXGig40lsvgKqyXrI
         9GfYtJuMpcL2mS/t168apSC1ZYptcms57HAlY+RcomziJVCWHzTFLzQOgxiPnvn27iAU
         GfNrvfCfnAW5aYHS5UuWymKNM212aCtbXZfpdK74ha3qaEwTF9QX5dUtouKJBYTC+dA3
         dy1YOhGE+5Lc5MXSVO7c/9qj9hlrRyYoy8/qbfZ+K8fjbS+dmBZxs2TJVOyFB+VaX2Wc
         qQbKwxgZSelWip03C+7AcVWOyVjI5+XaW2an1VvQN4w3MJEZj2LbB4bvrkuFD8jZRIqU
         1FdQ==
X-Gm-Message-State: APjAAAV4jPGOkOeeeYtqq3wNgtJpqFLCTH1nyXf98FAvrOHbVXJvINyX
        Mho1MWc8ey3lk3eRTTvgzog=
X-Google-Smtp-Source: APXvYqzBLukP2W0809eViEFsB3nITVw/aCkAWjBj+zSP+L5gpaXEdr7ysvG+e21kCCz6dwgCCCTofg==
X-Received: by 2002:ac8:74cd:: with SMTP id j13mr10568148qtr.385.1556921599506;
        Fri, 03 May 2019 15:13:19 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v57sm3221643qtc.10.2019.05.03.15.13.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 15:13:17 -0700 (PDT)
Date:   Fri, 3 May 2019 19:13:06 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/4] staging: iio: ad7150: improve driver readability
Message-ID: <cover.1556919363.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset solves readability issues in AD7150 code, such as clarify
register and mask definition, fashion improvement of mask uses, reduce
tedious operation and useless comments.

Melissa Wen (4):
  staging: iio: ad7150: organize registers definition
  staging: iio: ad7150: use FIELD_GET and GENMASK
  staging: iio: ad7150: simplify i2c SMBus return treatment
  staging: iio: ad7150: clean up of comments

 drivers/staging/iio/cdc/ad7150.c | 102 ++++++++++++++-----------------
 1 file changed, 47 insertions(+), 55 deletions(-)

-- 
2.20.1

