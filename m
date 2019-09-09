Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 558D2AD923
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 14:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfIIMhQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 08:37:16 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55271 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfIIMhP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 08:37:15 -0400
Received: from localhost ([46.78.15.232]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MpUEO-1iUb2L1YgG-00pv9R; Mon, 09 Sep 2019 14:36:57 +0200
Date:   Mon, 9 Sep 2019 14:36:56 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: adc: hx711: fix and optimize sampling of data
Message-ID: <20190909123654.xmpwuqwdlvjqhrlf@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:CmNxPPqG6woXpuSfbm3Mvoq5nBP/HMgcMrMoGynjILGEZsNxY/Z
 qmrcNQSKtanu6YUtJyIr32PjosKt1safXr2r0J7E1UypTNQf4XVXp7GbrNUHZYgUcN7T6k5
 yghTKqNDSAb24deM0T8AoNep5HgyXDUB69NJxwmsUTOorSohaPAuWv4EopY647WUQWSHUCV
 /RX3se7RFPCyaAYKH7QbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aHLFR5D0t7M=:/AggtR0Y0IWAxgKLjSK5QV
 bleFxxal58h41Vbe/qmoUjJbPOmAmGxiTiIqUL8Dk/zxnB/SApKP2+221xkxJHfi7st+9f2jP
 YAV0b0/4abDplbJFyIqp6SGTj9RSkUXYux6v12hTGwqIedCHAEcQQ/PvbFwbRxbOSKf9u/1sh
 8J2IRR5RPTGxcktAGYt7fu1GoIYJ0h2e2ZzzI8atfCc21Klw3V98qncpefc2TdQhQFSErXhcs
 SwMhq0F8V7M83HycHsKpqQPLrNvUD2+rI7AgvpjouWqwJvQofZ/nSDUFRLMWqEEOlnWqD6LUB
 tYAFaGpwRsVre3lT1nXCTRTo2SAh17p7YC8+pXS2VaUmq0WN3bJL4kmvcYd6u6ZeUuvREmwKy
 /RIsRF+5WB9tIRzSJxaaaolGKiDBVdRqpJ1uX9oO+uRrwypZ+2wQutcJGGkcHJXg+qu+zrUSD
 uTVIskoginAls4b6j6sHbqScrltTj/s5Lz7vKdwK3SKEvZk+iexHXA0WvwEqoWyXgUEXrZD+I
 VTd1Xp5aPBd+jk+zNr0vT3ZdZ+sux8c6bOGELC6bBc1F9k5+2UWCJKhe+MDNviBuSRACgqNGA
 ln3azg/qx+NdVEPxdBlDxexsD+g/BL+juLsLFvNi1mevOIrS8koD+RAgfKyzPccUMxrbSXfJl
 kP/w1AzsVWYgJudES4XutwGCrfxJLozKT1vpNYh2tbyzSxbwTGCK4VO/k0bSYqxAMwQmDMQNg
 YxcrSX4MkDA28LVg/5T/HGHQeFd7UnAvhwwmLKFhX1XDGZyO6HB7Y7/HA0LZOwzk9UyKh0xaM
 IXcpV1pC8bf/jpWB9dbyeFqJwQu1PBvT3K3cJZACOi3026A8io=
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

Changes in v2:
- Clarify which part of the patch queue fixes a certain bug and which one
  is an optimization of the driver without an underlying bug.

Andreas Klinger (3):
  iio: adc: hx711: fix bug in sampling of data
  iio: adc: hx711: optimize performance in read cycle
  iio: adc: hx711: remove unnecessary returns

 drivers/iio/adc/hx711.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

-- 
2.11.0
