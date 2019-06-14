Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727A246428
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2019 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfFNQb0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Jun 2019 12:31:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42528 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFNQb0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2019 12:31:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so3167627wrl.9;
        Fri, 14 Jun 2019 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NSjWY72/27Nxf7scfOqq9fJamExCtzdkq18+lH2oiWs=;
        b=FzfVqTouAeJEjXvpO2f1HVJWD9ymvouREUbknXILHtapXUNj0DSle1t4ZYy/GNsPPY
         lqfC/zuujuAwp+TNWDNpTZzhse3p2hqjxcZ9iymWFHDM1V4JE8EPODo3GCF7PdLREQmJ
         UKwlw1r5SRPM2pyicrMiEa2DGgg+r2j/E7z7IEKPODX7FQ2KCwplq2hoibmS4rOKoCXS
         wn3FtE2Bnnk2XP5QP6Piab2cY5aMtmZieVeFy2uDcyzZ2m2Nt9cpKQFJtTymu9wZ3dOb
         laiEl/LvAXL5gqeXGsP6CjcLyjBhmj/YydlZ2AEVA6+QZLtuhDxWngHdjosXQHOq4RXA
         0apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NSjWY72/27Nxf7scfOqq9fJamExCtzdkq18+lH2oiWs=;
        b=E9ifqTn6kEpYyE0+e0dvlk3426A9I+Ydmr9l2h26ZdobyKebPUJikHJhNNTQZpv60G
         qjd2Q4fGVpBsJARf5JkJ9FNtfJv0GnAd34s3btpv9eYKWVDJOBTzTp8mjl1DFwcGIYDz
         QwiGVz/ha8INKPNDT/zaIlK6XJ3jocu4vs9QkSPUstu/+Ag/f5moiwElq7uOAvxwqvum
         +4u3ZCRmFzgH7/0crIc0PMjq8oocKM0oRzP2gBleiYnIvMZitYfjsJMrWvAlr22g3I4y
         IFCsxKIw1rTo4iMsygnU2Cp2kfFMbd/XozMznlo6VKyRpCJaxpDNoZSh0/ghwqDxFtv6
         Cy/Q==
X-Gm-Message-State: APjAAAWzt64v89yZOCIQrDWtqe6uWvTVpLcRHBdsefKyD/Vx9g53iYWI
        DBKcxZwRhGHkM7jXPWmV+1A=
X-Google-Smtp-Source: APXvYqxzZWF80Pk8ck8ZMrwx8jNl4R0iWuKdJzK//3/wYsHze3qGUj3gxLO7PzuhjvOBKF6ZaPU/Fw==
X-Received: by 2002:adf:e50c:: with SMTP id j12mr9767121wrm.117.1560529884097;
        Fri, 14 Jun 2019 09:31:24 -0700 (PDT)
Received: from smtp.gmail.com (1.77.115.89.rev.vodafone.pt. [89.115.77.1])
        by smtp.gmail.com with ESMTPSA id h90sm8321470wrh.15.2019.06.14.09.31.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 09:31:23 -0700 (PDT)
Date:   Fri, 14 Jun 2019 13:31:14 -0300
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
Subject: [PATCH v2 0/3] staging: iio: ad7150: improve driver readability
Message-ID: <cover.1560529045.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset solves readability issues in AD7150 code: use of FIELD_GET
to fashion improvement, make operation more succint and remove useless
comments.

Changes in v2:
- Remove noisy patch that reorganized registers definitions
- Remove else to improve i2c return operation.

Melissa Wen (3):
  staging: iio: ad7150: use FIELD_GET and GENMASK
  staging: iio: ad7150: simplify i2c SMBus return treatment
  staging: iio: ad7150: clean up of comments

 drivers/staging/iio/cdc/ad7150.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

-- 
2.20.1

