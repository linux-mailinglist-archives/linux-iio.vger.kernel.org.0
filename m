Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473F911C941
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2019 10:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfLLJf7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Dec 2019 04:35:59 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:34314
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728230AbfLLJf7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Dec 2019 04:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1576143358;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=w0FazNewqkNs8YdPQjOHQnKwKkuu3mZLl8EwXAI4GQ4=;
        b=ANJXc3Rky85I9YFunNSO+qsBYLsG26dEyqi4DVTEFxuEXm365azWY4/7L0D6V3lG
        fmDWR5y68QWknZZm1zREOsmWBeDRD87eVvdEgRcJjM8jCah8QohJi+UoU9E/x2a5zZi
        7Z1eQEUOwk26Ko71vdCpwOcKH+TjXzQw3xeTKWRs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1576143358;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=w0FazNewqkNs8YdPQjOHQnKwKkuu3mZLl8EwXAI4GQ4=;
        b=VPS3XteqH6TtUXFQws12fTJfuumjnJm16BnDtmB/dfTdGCxOPBCGkdVC6Zrkw6NW
        0qmY8g2xesHE8E+1iUPUITx7lLK2Q8ovn8dGVrPz5KTNAFY7VJfAJnvwwktyJcnNEVe
        QWk4rfnwSSKF2NeHxmQ3aLi2AZCAqFX7nEC92sHg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A814C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH v3 09/12] wireless: iwlegacy: use <linux/units.h> helpers
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
        <1576075099-3441-10-git-send-email-akinobu.mita@gmail.com>
Date:   Thu, 12 Dec 2019 09:35:58 +0000
In-Reply-To: <1576075099-3441-10-git-send-email-akinobu.mita@gmail.com>
        (Akinobu Mita's message of "Wed, 11 Dec 2019 23:38:16 +0900")
Message-ID: <0101016ef9770a79-8bb3d210-14d0-491a-ba0e-e5eea30ddfaa-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.12.12-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Akinobu Mita <akinobu.mita@gmail.com> writes:

> This switches the iwlegacy driver to use celsius_to_kelvin() and
> kelvin_to_celsius() in <linux/units.h>.
>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Stanislaw Gruszka <sgruszka@redhat.com>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

It's enough to say "iwlegacy: ", no need to have "wireless:" in the title.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
