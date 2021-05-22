Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE038D59D
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 13:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhEVLba (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 07:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230238AbhEVLba (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 May 2021 07:31:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCBE361003;
        Sat, 22 May 2021 11:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621683005;
        bh=r6oIrJcxGb+ZHFevRXZslPbuhfScsE3enZEPIb9z5+o=;
        h=From:To:Cc:Subject:Date:From;
        b=cwKOojK2iUy9D98pyZTxwuhHHPV8oWklf2gwu0/WD6vzOuij/ArKSLGZiZhDJ0waM
         V1q366soUC9TyFFiykkZV/ZWQLejSTO9TWi/uJZidEttpCkN3M8SCBzlbw/mhUX1Zx
         BBA85dvIu4LkiB361SOZNhB+3et6wiBydPkFdn8W4PK7ENPmjqLhbMm1rvKnlFqWnA
         bpDRgxciZ6caiOAEXW6ksTnvIRHoKDJaSmZmXJRLumD1N+A8W/S0Xf+XxlW2gaxf8F
         lLCcASJb5xqGzTKbAj9o+Molxkiq7mFDfq8f/TLAtunLj06FGZ1I3WVEbOyZMn/s2F
         N70UCC6I42zKw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Peter Rosin <peda@axentia.se>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/1] dt-bindings: iio: multiplexer: Convert inline with other mux bindings.
Date:   Sat, 22 May 2021 12:29:06 +0100
Message-Id: <20210522112908.1611389-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Now yaml conversions of the main mux bindings have been posted for review,
let's do the IIO one.  Rob, feel free to add this one to your series if
you are happy with it.

Based on
https://lore.kernel.org/linux-devicetree/20210518232858.1535403-1-robh@kernel.org/T/#t

Jonathan Cameron (1):
  dt-bindings: iio: multiplexer: Convert io-channel-mux bindings to DT
    schema

 .../iio/multiplexer/io-channel-mux.txt        | 39 ----------
 .../iio/multiplexer/io-channel-mux.yaml       | 71 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 72 insertions(+), 40 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
 create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml

-- 
2.31.1

