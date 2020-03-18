Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F95918A2E1
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 20:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCRTHc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 15:07:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45428 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRTHc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 15:07:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id m15so14188314pgv.12
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2020 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SLRLiX9u8sqIIOBIxJVUp11WU6ba1yuoaRErY2Y3s4M=;
        b=YcoSrqe0P0xYIOCyS3zhEA4SzIfagTLj/71PKOBqbkikayHbIVTcZwjPxe9AX3vqyh
         DcDH1Dmi2/bHTPQXvkAZE1JoU4+yZ7/Uw1Sz1ecNWLaQiOuyLHBmuJh7yXeYgEADrJb4
         pJA4xaeBeWiSSurKGX1PjyfYy93Czu2WCxpYYA8Ig3LXweV9WLpCds7jc1bqGLtAK5Ge
         tLRpAugITMH5IpooscZk8KyoFnkJolDKHGnjJoFyEfYs1LbQRGcRBAGS4agvgCjeftMU
         9mczb68fVY/bemmWef9flKdAF2bpov18OybG15V0AQMpfWFh/36oGnzgVzf8XSwV+9AL
         dDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SLRLiX9u8sqIIOBIxJVUp11WU6ba1yuoaRErY2Y3s4M=;
        b=eFOoc/f7BOlFIWwpA4XpnI2fw1pFDsDLPdV86+7ibb6FRPO2NtT+sE3usQnA+tPPbv
         6Nq/RunAzcVyL/UOzqyWbINniDvkspWbW34wFioZXNx+tzt6OKGrXUj+HWT8QyAgifkV
         e2+dNv+0yz3/etdHwhddQinixBOauRvyjsbny9I6Myk4M8qJ511BKLtjPadxBxiUKxFY
         Iar6ydnTKjyNaDF3aAZE7Ihc6nf27EaVrbpaU1Csxu+Nj6IvC2D1rKI9Yu6wVi3wGOz/
         N8OL1WsdQrk/u6cu+EQQKs9UjPYtKenggfzl2L1w+tvEsIJ1CF3noITQ/6E6Y5/pxSOk
         ZBNA==
X-Gm-Message-State: ANhLgQ3aw8TBHFCCirkLprLkAbm1Ew6smurZM5OFFqFVwcH8/1MS0KZt
        +LSFdPIuRwVYNv2am3zk6TU=
X-Google-Smtp-Source: ADFU+vuYInjRBuyPuaWlFBjLbJ8BhXC1L8ehxsOUFwylxnD7bcAKGZsAJB8n2ZKlFKOuVQIWANh1KA==
X-Received: by 2002:a63:2ec1:: with SMTP id u184mr5801633pgu.446.1584558451685;
        Wed, 18 Mar 2020 12:07:31 -0700 (PDT)
Received: from deeUbuntu ([103.241.226.97])
        by smtp.gmail.com with ESMTPSA id x27sm7588780pfj.74.2020.03.18.12.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 12:07:31 -0700 (PDT)
Date:   Thu, 19 Mar 2020 00:37:25 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 0/3] staging: iio: adc: General code reformatting /
 cleanup patchset
Message-ID: <cover.1584557481.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Address code formatting warnings and check messages flagged by
checkpatch script. Also include another improvement for correcting macro
name typos. Changes intended to improve readability of code.

Changes since v1:
	1. Add separate patch for code re-indentation comment
	2. Add separate patch for correcting macro names as suggested by
	   Lars-Peter.
	3. Update variable name from sync* to sinc* as suggested by
	   Stefano. 
	4. Revert patch intended to add space around "-" operator. It
	   was a string with a "-" sign further formatted using
	   stringification. That patch is out of the patchset now.


Deepak R Varma (3):
  staging: iio: adc: ad7192: Re-indent enum labels
  staging: iio: adc: ad7192: Correct macro names from SYNC to SINC
  staging: iio: adc: ad7192: Reformat lines crossing 80 columns

 drivers/staging/iio/adc/ad7192.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.17.1

