Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5791C18A2EA
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 20:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCRTIb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 15:08:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35482 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCRTIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 15:08:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id 7so14214444pgr.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7tweYNsahvHJxsolfg9Oq0fKb7Kxbn1C7cGKh/PxQeY=;
        b=azQmYBSZ8HPyU0jIA3EK0F71XgH4sUGOL0Z7Ar9iC2WP7P2sJh9LakH2k7g11UZAXk
         1zmAR787av3BvLfvsrs7ntaf1RhC3Giu0uvKQ7HI0QF0opPmZ8uECU+4CPz/CjSS1fbr
         o7Msy3CSJiBnTjGm/RpcpR8cVPpX32f5zOqS2rRXtq5I3Um8bbR1bZsL4vF2OGXhB/fx
         Zt0nKJbW+BlT/C5RT80kgFLvfNXM6UxHWdfvvjs3Aj6X2596HC6+lXkG1uILkOfVxSrC
         TNgMI2/MdDMuZANZlg+N1LbvenEbqoUo47Ro1TGtzoDwwHzgM0kLYpsEHUpo5s8/4dAJ
         K+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7tweYNsahvHJxsolfg9Oq0fKb7Kxbn1C7cGKh/PxQeY=;
        b=dzqq7UjJXQJHSrv897LusVxNUhlQCfIvVk+8ZzRxNL6O+w5BpfhvgGdT5ulag8yqf0
         GHQDy15UTXfEAk3wjt/4O2xGRcjm0UP2ZicqIPAzJzeobzGzH2gbgFeBMk3RLoeSx8IE
         R8f2LXTu/yhXY6uC5LbGgMp6/HRrWYPw17FhowqKmbdPP/2oJAo6zKd4wYqXg/UoG75F
         0gH0Rcjb7jnBwi2HM0O2tXGNZjMDE7z7StsfcMG3OtTyUuqkYCrfSjT9llt+XgOFtjtL
         R60gvODnJ7tIrJ/oA/si9k41OdigAIQGZ8jFNhP65xDrFR2LU+h4g1WH6zIT4Oo8v3NL
         OjMw==
X-Gm-Message-State: ANhLgQ3ME5J4EKuJd9Yn4BcCpTQqOawtgCiqkPd2PBy7hVjNBlPf5ZLS
        tZtHf1WJd+KwHkXhYBQcbyQ=
X-Google-Smtp-Source: ADFU+vtExvcnnKg7t8uc0qlT5vG2coaOY0gZrcwT416qj/nTr47Xx/EzsiGPpwmWD7/B6sVgHjRkYg==
X-Received: by 2002:a63:8c18:: with SMTP id m24mr6228929pgd.70.1584558510837;
        Wed, 18 Mar 2020 12:08:30 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id z16sm3105758pjt.40.2020.03.18.12.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 12:08:30 -0700 (PDT)
Date:   Thu, 19 Mar 2020 00:38:24 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/3] staging: iio: adc: ad7192: Re-indent enum labels
Message-ID: <7aa18b6226a644e12302a055cbc17b41a2ccb02a.1584557481.git.mh12gx2825@gmail.com>
References: <cover.1584557481.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584557481.git.mh12gx2825@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Re-indent enum labels as per coding style guidelines. Problem
detected by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index bf3e2a9cc07f..51b1cd3ad1de 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -156,8 +156,8 @@
  */
 
 enum {
-   AD7192_SYSCALIB_ZERO_SCALE,
-   AD7192_SYSCALIB_FULL_SCALE,
+	AD7192_SYSCALIB_ZERO_SCALE,
+	AD7192_SYSCALIB_FULL_SCALE,
 };
 
 struct ad7192_state {
-- 
2.17.1

