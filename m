Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 743F049DA1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 11:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfFRJmA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 05:42:00 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfFRJmA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2019 05:42:00 -0400
Received: from [192.168.1.110] ([95.114.66.109]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M26iv-1hbFkb3jpJ-002UDo; Tue, 18 Jun 2019 11:41:56 +0200
Subject: Re:
To:     "Grim, Dennis" <Dennis.Grim@teejet.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <DM5PR19MB165765D43BE979AB51A9897E9EEB0@DM5PR19MB1657.namprd19.prod.outlook.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <fb5c1163-bd0a-ab22-d3ed-3c7b4f7862e6@metux.net>
Date:   Tue, 18 Jun 2019 11:41:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <DM5PR19MB165765D43BE979AB51A9897E9EEB0@DM5PR19MB1657.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YViguX+LrOwdwVJJO62D+q4AifRp5xKxIr77rS0kh17dh2To9HF
 uIlcilTWaDLZwsxsb/Mpy8o1Bs316u7rADp1RYJGyfRAShuDg2DYSDw9SEag7fmiilX6fPz
 BITQk+HRhffFtY9EPqhDQiU+RTmTf50QaR9W4Xm72+LbO+rphVofmAgt7LXQeCUk9JTPbB3
 5gqEyR4f7wqa04VzdFkGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Z7qpC7IaFY=:Pzd9pQaO0BkTRpknvU4BKM
 U5Q8+zjnUzwV4nWMIbNY995WaDfXfXaLV5fp/jcmRw20xWw5/fZVxrvu6I+uG7f4iESczgg8/
 hWWVsti8Gys7UHiY+BlXhSGjPNJDM4Xm1D64wO4lvHUNXmlDGy1Z8AzIxY1Ou7BzB20+mli1l
 rK7oJuSChdQM93IOnDOcBTPPCKwxEiItzARMUsCvkSMwZtL9/lCULx3jP6ZnHt07X038x4G/v
 XPJlkhInF6TedTGINUHI2j+ZwcolQc5IW0zuRM+QznnoeJmAZNvTqSPhs2hm9QmnxvA8AXueQ
 UDl+2BW9W+dEccuiHSEkPc9rTb6ryhrweN5YtunEh9z6RP6rfO75rTJVKH4pLL8G8TWaIHQSq
 gAx4MWY5yH9iHhDOikFIWEFgtVr0FrsBUqzbWuyHIDyX5XUoXVZS+VZkcArUmbDfP51j3+C8h
 OUailgKIqOFHeiA0CXx7Q+fUaQmjAq92ZiTMFm7eHBI9SNa3oFI2DijhTJsFEJug/npuSGwdS
 jasnyXhgwgagwnX2RMTFTEcpVnrtu6xMAaGo3aYohWatC32Z9HW7yYfFTd4kyeOJAU106KsK6
 ev3UhajFlt5vHBx5u7pRQtaQN7XpcFNBnVQAQqCi/n/oO/j5/i5Tvn3aZ8iCLqGf3F8F8GLI2
 Sf8RK9vC5dvgiRdE66vJfjeke/kKRMNFUyTiqK/7gUut7DlpYEU7PSr4ShsWcZ8bQ0tiQ08U3
 v5oWrCBALUt9C94JqDosd/kZJP2H10eTUDRca4OGo1Bg0DSJYlLL7iMf4ZQ=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 17.06.19 16:58, Grim, Dennis wrote:
> Is Industrial IO considered to be stable in kernel-3.6.0?
> 

What exactly are you trying to achieve ?

3.6 is *very* old and completely unmaintained. And it's likely to miss
lots of things you'll probably want, sooner or later. And backporting
such far is anything but practical. (I recently had a client who asked
me to backport recent BT features onto some old 3.15 vendor kernel -
that would have taken years to get anythings stable).

Seriously, don't try to use such old code in production systems.
It's better to rebase your individual customizations onto recent
mainline releases.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
