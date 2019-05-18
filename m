Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD42256C
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 00:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfERWlu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 18:41:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46853 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfERWls (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 18:41:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id z19so12107636qtz.13
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 15:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfANJ0NjSuT03hGxYrrybmRloobQ2aNV6k4ZVS8sjkk=;
        b=s/VAevDUzrN4FYKLzj6wS9/MMwq+kuH3vDcW/F4Fujom2rI550pYSulPYPa2DHYIoa
         vziuEPs7+KFZKSOy4dl3S8XsA3rR1xpt4h67jOFUcGvczSirRSoPZZ+ophuYFsVN0nKA
         KJXJ7PjsM6A0QMDUt4mE2IpJKVMc0JBo+JQlHXzpUXpOCQi3bR+vLnDAiEUhXrmDpJpx
         2jS67Tl+3ptVLwfqcKW8MDhwDjGiqfldiuA3Byur4rqXRY2LArH0gKJQirF/Ybv2wWXT
         9PyynABXznVJI7sX4K9U1EYK+stMfTaBmSqOdaQWcTOgDPZVPt6aFNn6D0wrEJNNO2o3
         rMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfANJ0NjSuT03hGxYrrybmRloobQ2aNV6k4ZVS8sjkk=;
        b=Y0JuHLNx8n1Hv3/yks2rFkSW5w5qbyxMKLEBz05xjwKrLzay5I8EpQ4USzNW5Rjt4e
         ujw4J9wXEBb8vkbi3JSQx8kOY3h1ceB5KsHlhGSHS5YbNjykETHmPRbsfKbD3+wvibss
         dXGnVovOPfxS6PMhJqE7nYu4oKjSa/eonQm0co6NYGKoQtjgY8ItkQMX3/u3GSObBTDs
         8TnJKpN/ofsNRKDA888uOvipCs6mWw5QiN9IvakSah4eHWW2wmYKqE0+02IIJsIyy7GC
         BttcqMg5x3WlccYzHmy7f/s+n2cLwczjb1s8s3ZTlTYpP5/zMsy2aWnu9uriIhaOhTrQ
         MToA==
X-Gm-Message-State: APjAAAXBW3v80QPfqptn1RoCTtjGiuVZ/szyQDKupCrQSTON1E//JHGp
        OhgvGcdGLy9rQ1kS88EDFZv3Bw==
X-Google-Smtp-Source: APXvYqwdNGqtocpFV8e81epFjCB39YB58+eSXKAmOz6uUNBChWqLKg71GxYgbQw6wTK6oeDaMXtTQg==
X-Received: by 2002:a0c:94b9:: with SMTP id j54mr14290525qvj.54.1558219307081;
        Sat, 18 May 2019 15:41:47 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d32sm7348992qtk.0.2019.05.18.15.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 15:41:46 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
Subject: [RESEND PATCH 0/2] Enhance dt support and channel creation
Date:   Sat, 18 May 2019 19:41:34 -0300
Message-Id: <20190518224136.16942-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series of patches set a struct of_device_id with all the devices this
driver is able to manage and also add a macro to facilitate channel creation for
its two capacitance channels.

Bárbara Fernandes (2):
  staging: iio: cdc: ad7150: create of_device_id array
  staging: iio: cdc: ad7150: create macro for capacitance channels

 drivers/staging/iio/cdc/ad7150.c | 39 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 17 deletions(-)

-- 
2.22.0.rc0.1.g337bb99195.dirty

