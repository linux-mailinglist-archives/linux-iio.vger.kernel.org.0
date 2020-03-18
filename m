Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E681894DE
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 05:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgCRE0U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 00:26:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40830 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCRE0T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 00:26:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so12947066pgj.7
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2020 21:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QIWYOHYAGsjWkLX/08hd/R24tHKjTlO86LchXE2jJvs=;
        b=Lw3tPlwqsHsaM4Iu9nYmzh+7acCIKGkcSNwJUD9rMocorEQZ/JNYVqaeb8lpRQG1l8
         16VI0lIUA/dNIbsayo/BZDmKXR0S/Ae5hTvOZg5dVNdRZj5e4j3hQqywbNooMvyUg+Qq
         ozSlrqii9o6bh5sWNQuDOOAcvE5todOFUGtYC7EzfZ2rxxCXH1AULSjcDbgvm8/MGPLe
         aGoEgNGYA0/DyDiPfTtiO52/SGKYq6DPrTsxe0J9iMc+ZRJDsn7Xv+ft444/gK68Ol4v
         JuKPbd/cF4hl2VhyapJUx6iMMkUg4dgAC5oZdmH2DazNCJNL06/g0aEcwU+YqjHNViHB
         wrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QIWYOHYAGsjWkLX/08hd/R24tHKjTlO86LchXE2jJvs=;
        b=fBv2IQPkQ9fV+Mlmlp+SeYEjWcWjPAUdeZqOhXiPArrl3eyP5+GPkXTaazQpkAJChH
         Y7McmxHPGmasZaWbiur4Y2ieFA1DHzbLmjBD59WhFJaXNFNGB1l6zE/nw3xzDObEVX8I
         4Oax0wn3NNTDW7ojPOgUpj6Ov1qbfHx9eO8AVNB0L/cK3bBhdBfnNT2NRPGDflBdUfyC
         8stlCbRlFe/BxyeN82E7d2CeAicZcQu6azRtb063AObigoKftGbYEvil368baSyuiPDe
         ahgFhnAQ6CWPL53lwjfsXij1WljjymOG+uYJBPiqxe0CoUDDybvdF8W6tnHOs3bLIlyc
         XZHw==
X-Gm-Message-State: ANhLgQ3ndc8lxjRDlstYYwUGJKWuwiABuMRZwwa8OzGSyuoNqkJ+yoQD
        /jrOywP0GTEhny9vEX4Bu6k=
X-Google-Smtp-Source: ADFU+vvVi0hSQ83p9kKvlDLMgB8KlQMDf6rF/OJlqXE9K+N+s/Kxi3JUAlDGhl3UtODe1cGOApDjtQ==
X-Received: by 2002:a63:5561:: with SMTP id f33mr2658208pgm.20.1584505578752;
        Tue, 17 Mar 2020 21:26:18 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id 71sm4784024pfv.8.2020.03.17.21.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 21:26:18 -0700 (PDT)
Date:   Wed, 18 Mar 2020 09:56:12 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/2] staging: iio: adc: General code reformatting / cleanup
 patchset
Message-ID: <cover.1584505215.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Address code formatting warnings and check messages flagged by
checkpatch script. Changes intended to improve readability of code.


Deepak R Varma (2):
  staging: iio: adc: ad7192: Reformat lines crossing 80 columns
  staging: iio: adc: ad7280a: Add spaces around operators

 drivers/staging/iio/adc/ad7192.c  | 15 ++++++++-------
 drivers/staging/iio/adc/ad7280a.c |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.17.1

