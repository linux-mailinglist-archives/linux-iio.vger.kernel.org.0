Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757D639140A
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhEZJs7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 05:48:59 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:34457 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhEZJs7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 May 2021 05:48:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622022264; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ofeG/Aq6GFQsmGK3ATw6bdG6aM0kfW8YD+MNL/7SegjEYyvgPnD50f+BSYKK1nz1g3
    4AAZ9Wso4sO8lH1j1WRTrBinjxVy4axgsGJPj7r3G4a2j23Hsixul484nntjHCE2Hpv+
    Yea4sUgx6uR2eS+H3L4s9vRdjs7n6zMH9eEpMFnIxOi66hZBMo9u3Y9RKSRcyS9Dlr4K
    0VSjmmdfU+L7FvYMZhDnNthOZtoaXMRo+DtLW7dwNF0jMR8hDSQQqmj0htVVwM25HP3O
    ZHTiCpxLnVC2Ao51IJcgFDYHx0Cib9Tb8yfylm8MhbKBu2mhsih/A7DYIEhwc4x43IFo
    LTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622022264;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QVOMXLRWjlmCV9N5QIsOg4wDezgi0D1fXUhjrijitHI=;
    b=KaiAto3wdpM0n3MYj+igxfPJCllw62O+Mku2dLo/gpJM2j52POQu99PZ36IkMlsQSw
    asrNbAlQxdc+z7rUz8uXXj8GhCYHMGZQcT3GRCkWM98RaX5aFnOcbGxMy+DcHUwjaFC5
    1UHI7VfhfWBv/ftERWhKV5GjLKbg9M9XWPAArIYxLaqJodJ65cgzMxRvR8TBGl7sMOXM
    jMIp4JAsgMBgtzBCzTSOCa5ja34hNBszpoSQo2Uipue+hnYjGOs8vjxHdmg9QQJGKMil
    g0NZWrBB95QfCQ8Ha6SyijWDB6lRpJUDGmT/xmGT9PEv0QQKlkSdSOReOlQBCmj9H+oH
    mwKQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622022264;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=QVOMXLRWjlmCV9N5QIsOg4wDezgi0D1fXUhjrijitHI=;
    b=ZJqoXci6jvv4nle94AvLxuMvBM8Bj/QU/rL0uZCGhPrdaKkezMOfwdG84IscyLCSOm
    v87jZNNBATiPLNf8uz1K1RbDuBpQEt1eJe5regvKpOdp0SICXgCUfrG9A8h33XTSF2pp
    ZjCDlpH5WRY9uErb9j6ctmVJ+ancwN2mz9mL2oEALy2YQ+tu3m+Co5fr1t5mdJUgoUuy
    kHFe9AsRCwbIvi80AhO9ingQVIPmUBxLOPDLKnVph5WTt+WhL5GJb3PGw90UV8HRYgOY
    llT+HZjqWToxxy7mk6UZ4s/qbQlGNVvh8Iv8XjHemQxwHZc4gXZGVqpxB3QrVk+HXeK/
    VBiQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6JG0s="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.2 DYNA|AUTH)
    with ESMTPSA id w02ed1x4Q9iO6K9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 May 2021 11:44:24 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/2] iio: accel: bma180: Fix BMA25x bandwidth selection
Date:   Wed, 26 May 2021 11:44:06 +0200
Message-Id: <20210526094408.34298-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series fixes the bandwidth selection for BMA25x
in the bma180 driver. See the patches for details.

(Normally I would omit the cover letter here but Jonathan
 mentioned this makes things easier... :D)

Stephan Gerhold (2):
  iio: accel: bma180: Fix BMA25x bandwidth register values
  iio: accel: bma180: Add missing 500 Hz / 1000 Hz bandwidth

 drivers/iio/accel/bma180.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.31.1

