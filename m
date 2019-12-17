Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA9122990
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2019 12:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLQLMF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Dec 2019 06:12:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36146 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQLME (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Dec 2019 06:12:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id d15so5954770pll.3;
        Tue, 17 Dec 2019 03:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kY9iDk6ujSVpRSx3i8FBNKdQ/NwXC042Gb3HxrCWJLI=;
        b=LJHEfkeHlzDWQISdNkdrI92FgGwmERgCSamdNW4XzU3/X5rhVo6Ql0AIjDaRtztLU8
         N+muQJe0kRVDscjaowPmrETQd3W4qztJv+0JxglpXEY0wcX4Hagklla/7+5W1emK3KFf
         a4zrRkFOZevNjOn/mMeRhlnBhUkpcJWR76f1RdqXZ/g2w9hNh/TcN+0phaaw2UDgubcq
         /DBbJOW9UsHjUdmWBIeu3P3jEBP+FpWL8YEOmVjBucaj51PF0/ud50/p+i7fHXWy5zjv
         kNSMEuATK1ze7pCxM1wbbcJZ3+CGMIy0WiTQnPAa8cC9YbKsgu91CW7RJ62j0PrsmpcV
         z9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kY9iDk6ujSVpRSx3i8FBNKdQ/NwXC042Gb3HxrCWJLI=;
        b=DOLRVRt9evdiNSpy0ztv3FkgVYJsFi829wCrFFsphVomD8FVq/p+gDqHafDZn7Nvjq
         dzKOHe7mGdWJbH/J2G8sD/+GhFnOHSvtzjvV/76gNcjjnhs6Uposb9JZGUQ10pYeeukg
         BGJluFTa/nGfbnFOfjZTLWlKOpOzXRNnw+v9NrKhuhsWEO6V4SM4GvAT41da3RT+YMQa
         gXs6EJEDt9cwXL2it41jF1vNTko1nsdGGVOcp62B5t8SktoEiSqMENKA/PRjPvXrYBT9
         Pldo1WrzKzMil7pqtkuJ8ULa93aLwMg7rMYF+3fFc6rhWKpJVLEG79N5FOfk1+yNlKf2
         y+sQ==
X-Gm-Message-State: APjAAAVNjyD/eDKrUS64JUvDRzz4+GcSqMynazN/h8lRFXehwF36xCtz
        Ojne3I30MO1ovF2kEw85mO0=
X-Google-Smtp-Source: APXvYqxYw3VATrq7dAAcXPBZqzaZ6RSACsCYh+aRAb7KVwc9VY/UVgXlAFtChl7rZGp+DiAVZl0UXQ==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr5194967pjb.125.1576581124196;
        Tue, 17 Dec 2019 03:12:04 -0800 (PST)
Received: from brcpsddjunho-l.padtec.com.br (apolo.padtec.com.br. [200.228.158.130])
        by smtp.gmail.com with ESMTPSA id 81sm25855190pfx.73.2019.12.17.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:12:03 -0800 (PST)
From:   Daniel Junho <djunho@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: [PATCH v3 0/4] Add support for the ad7908/ad7918/ad7928
Date:   Tue, 17 Dec 2019 08:11:54 -0300
Message-Id: <20191217111158.30888-1-djunho@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds support to AD7928 family on the implementation of the
AD7923.

The ad7928 is software compatible with the ad7923.
The ad7908 and ad7918 are the 8 and 10-bit versions of the ad7928.

Change log v1 -> v2
- Split the v1 into 4 commits.
- Removes a buggy line committed unintentionally.

Change log v2 -> v3
- Added a comment about the last channel of this driver.
- Changed some macros that are used only on AD7908/AD7918/AD7928 to AD7908_*
- Simplified the MODULE_DESCRIPTION

Daniel Junho (4):
  iio: adc: ad7923: Remove the unused defines
  iio: adc: ad7923: Fix checkpatch warning
  iio: adc: ad7923: Add of_device_id table
  iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928

 drivers/iio/adc/ad7923.c | 73 +++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 12 deletions(-)

-- 
2.24.1

