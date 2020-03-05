Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6333617A730
	for <lists+linux-iio@lfdr.de>; Thu,  5 Mar 2020 15:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgCEOQi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Mar 2020 09:16:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34971 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCEOQi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Mar 2020 09:16:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id r7so7245042wro.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2020 06:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVZar5xkSPk6YGh+bTNxYG2EDRiPNf7KW4VrlT0iEPA=;
        b=YABdlOZaxtS1tkHeJglauXM3sSjL1G3nd/JhAltpBYc771uts8/R0PFOwpn0b9FPnp
         j/0FyC+n6Hr7Z5dwpvyEVdvppECu0QW/yxt9TEZ8m6vor1ipWdXJ4o12OwDBLJeKD0xO
         iSUJx1rVQKzjzl4J8YKuksMmg6GrZFdWN5XK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVZar5xkSPk6YGh+bTNxYG2EDRiPNf7KW4VrlT0iEPA=;
        b=ipdE8AVRNToAY41FAymcdw8n+TpC2ZLBn/6nlHi2LLjyrUkL2/sKjeBFnf50iG1ofs
         ouAl2p9dOmVGksHGP9cap+N9vLt7U0zyc3Lj7cb1mzAlJN+fYt7/Hvm7Bsqp9SpverPg
         n9MOGcS0K3tDTaPBh0zWpakMODPCX/g2AP3xSSzB/4IbgJRUOCfs9cBFfq7OCsB4/hsO
         kw6/i/iu5H4HvBqIfceTa7ro4bj0BD+PEoi5soV+5238QyvSy+D7Q9X2pN4Blf4vJXgp
         osAPYKcXKlOzSiIvbH7SVdbnR385kD9TDPhGyVPnawHrHPSziQKoS1CM6EiEHmAyOdbN
         Ea0A==
X-Gm-Message-State: ANhLgQ2ezqCo7ONw/qNUIQox5WFH1YQGzlowmEJEQXa38T+IUx7dvuuE
        p79neYqHJwCivYPB8qX6JNozqIk8qtjC
X-Google-Smtp-Source: ADFU+vv8/RniCxaIlHJKPvos3cCiRToBzNAbXYdpo08qLTfgIKkfxiJyqi3t0ENPE5SA8KdjMAkTPg==
X-Received: by 2002:adf:f547:: with SMTP id j7mr698915wrp.139.1583417795495;
        Thu, 05 Mar 2020 06:16:35 -0800 (PST)
Received: from odin.spotify.net ([2001:2030:49:0:b4e8:ff8f:e413:2a12])
        by smtp.gmail.com with ESMTPSA id a5sm9686927wmb.37.2020.03.05.06.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 06:16:34 -0800 (PST)
From:   Mike Goeppner <mikegoeppner@spotify.com>
To:     linux-iio@vger.kernel.org
Cc:     pmeerw@pmeerw.net, manivannanece23@gmail.com,
        Mike Goeppner <mikegoeppner@spotify.com>
Subject: [PATCH 0/1] Adding support for range ignore on vl6180
Date:   Thu,  5 Mar 2020 15:16:14 +0100
Message-Id: <20200305141615.110423-1-mikegoeppner@spotify.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I've been working on getting support for the built in range ignore
functionality on the vl6180 working. I've implemented this via some
additional dev attrs in sysfs.

This functionality is described in [1] on page 29 under the "Range
ignore" header. The relevant registers are covered in sections 6.2.25, 6.2.26, and
6.2.28 of the linked datasheer.

Would appreciate any feedback -- thanks!

Cheers!
/mike

[1]: https://www.st.com/resource/en/datasheet/vl6180x.pdf

Mike Goeppner (1):
  iio: light: vl6180: Add support for range ignore

 drivers/iio/light/vl6180.c | 180 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 3 deletions(-)

-- 
2.20.1

