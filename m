Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E47AC605
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2019 12:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbfIGKR6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Sep 2019 06:17:58 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfIGKR6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2019 06:17:58 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hEd-1i1swp20jx-004lQb; Sat, 07 Sep 2019 12:17:34 +0200
Date:   Sat, 7 Sep 2019 12:17:32 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: hx711: fix and optimize sampling of data
Message-ID: <20190907101730.gqzvu65dgsllk6tk@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:PfmnNlLbi9tx2lsqGYAr3ZdfkZ5g8xF5imXpu/Eot35iWeWMMkF
 h4xhzxDf1wkELd3O32gAaeAoiEua3NjZqkHGlFahuQDbLFvYeJYzGRyCidooSa4S3V7woL1
 RWrJjjzPHPXb6Up9vIUZ8zoBrxgtkpLjAfHme64PPgJqov4/DfzwUO6DEOkzyAgDq3PM3S4
 TwNoCMAMI8UeA+/aVQfXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7s6rw63TDtg=:WoFLCziDNBg7x0mlWJOEbn
 zuuEw01dla1GcVmrpMKDLNRvDID3ZBesjN03ipdpS+oTdkvfciW4wzHwKddeCQ3tg8XH4C9fY
 /kmyGKA4vtf/vlVRV9ACh3IgBG4uOVY9ajqd5duDf6ILbegGitNjmTVfhWezIJeMygZ05XNt1
 H/QuGyNZ6wHkCYCnJTcSI1BWU5MvYcd4RV224TAzR9tVctO1SpE8R+gmlI2GODR15MDb0HC3j
 4OmGoBd577HaIMi9VerdbhXOmqpzXwepiVwWjJDGlgEwnHJDNkeXUDgIEn4k+CxF13m2XEg+V
 u0ZpNfo01eZIhSTGytxW25QBIfNKEoKN/Rr/9JyQ0BjzUI6xS4+D9s1hLYNY+5/M7QazPufUr
 4F2R1s/1sAbA+f6AcYodD41d9AVbrKI8xJaMaPGktl6M0vINBi+xgvDnL/Y3DTaG3p8yXTqF8
 RIdDsycXrz9YiAUu+bLezhb/lw75h6sygeVegEsYXBrZFEU9SBegvG/+pAUYjmy+qhOSCYZ+C
 M6Jrt+pAeZUEQ26nxf64iBCSRfCx38gdadRb3UfzhEYGDohJoACBHQN13gdUJuk+7y+Ekjb2p
 lncfs9pcd4Yi1HX1RZGwyAAX4DH2egWFAxsgO+viETDeY6j74EWdKy/HRUHSDXqLAUAd9UHom
 v0igQ4Mh+vh8G6ieso1aqe/FuWlwXJtdwnIs8HbxjbrQPs1J9BqgEMRVEHEkVDfMrIZIekBbv
 bFwKda80fWpXedxAgDAAivBTe9Q6UNaOIhBpbsGMH6aH198Re8jWhlcAePgNRV8CLKaij1CAe
 aZbfcNRhPx/MP0khlG6ifKyPWDuL8jt/nsEKeNRhv8dfXH9edE=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch set fixes problems in the sampling of data and optimizes driver
performance.

It was partly suggested privately to me and i got the allowance to use it
further. But because the person is not answering my emails related to
the question of mentioning the name for a long time i submit it without a
Suggested-By or something similar.

Andreas Klinger (3):
  iio: adc: hx711: optimize sampling of data
  iio: adc: hx711: remove unnecessary read cycle
  iio: adc: hx711: remove unnecessary returns

 drivers/iio/adc/hx711.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

-- 
2.13.3
