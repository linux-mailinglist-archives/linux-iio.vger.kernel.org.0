Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413BF44B438
	for <lists+linux-iio@lfdr.de>; Tue,  9 Nov 2021 21:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbhKIUtD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Nov 2021 15:49:03 -0500
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:35440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235551AbhKIUtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Nov 2021 15:49:02 -0500
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 95F5C7DC92;
        Tue,  9 Nov 2021 20:46:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id BC36218A600;
        Tue,  9 Nov 2021 20:46:12 +0000 (UTC)
Message-ID: <846fb6e2b711ca09b89317d0117826eafc9f5b3d.camel@perches.com>
Subject: Re: [v2 10/10] iio: imu: add BNO055 I2C driver
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, andrea.merello@gmail.com,
        Andi Kleen <ak@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Date:   Tue, 09 Nov 2021 12:46:10 -0800
In-Reply-To: <4d812d76-07ca-1eb0-407d-78179628f0ba@infradead.org>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
         <20211028101840.24632-1-andrea.merello@gmail.com>
         <20211028101840.24632-11-andrea.merello@gmail.com>
         <85ef90ad-0d3a-6cb7-529f-667562b2ad71@infradead.org>
         <CAN8YU5NiKz2JiNr-47OC4==N8L67HDshuH45BifnHBae+GUU-g@mail.gmail.com>
         <021c6fe0-8131-a4f9-9cb0-2f4771d35da1@infradead.org>
         <80960e445c986408e4ae9a20ac42c5b66d4d8046.camel@perches.com>
         <4d812d76-07ca-1eb0-407d-78179628f0ba@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.40
X-Stat-Signature: mhte6ccyh3ngy8e7zurgnsmkyiazqaoh
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: BC36218A600
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19+oTqAQeeHzJ5U+ZxRAhPKTw8pIqxtIoE=
X-HE-Tag: 1636490772-693305
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2021-11-09 at 11:11 -0800, Randy Dunlap wrote:
> On 11/9/21 10:21 AM, Joe Perches wrote:
> > (cc'ing Andi Kleen, who wrote this code a decade ago)
> > > Joe, can you identify why checkpatch does not detect missing Kconfig
> > > help text is this simple case?
> > 
> > Original patch here: https://lore.kernel.org/all/20211028101840.24632-11-andrea.merello@gmail.com/raw
> > 
> > checkpatch is counting the diff header lines that follow the config entry.
> > Maybe this is clearer (better?) code:
> > ---
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Hey Randy/Andi.

I like this patch below a bit more.

It shows the Kconfig context block in the output message and
documents the code a bit more.

Care to test it again?
---
 scripts/checkpatch.pl | 53 +++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1784921c645da..0b5c0363119ff 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3480,46 +3480,49 @@ sub process {
 		    # (\b) rather than a whitespace character (\s)
 		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
 			my $length = 0;
-			my $cnt = $realcnt;
-			my $ln = $linenr + 1;
-			my $f;
-			my $is_start = 0;
-			my $is_end = 0;
-			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
-				$f = $lines[$ln - 1];
-				$cnt-- if ($lines[$ln - 1] !~ /^-/);
-				$is_end = $lines[$ln - 1] =~ /^\+/;
+			my $ln = $linenr;
+			my $needs_help = 0;
+			my $has_help = 0;
+			my $herecfg = $herecurr;
+			while (defined $lines[$ln]) {
+				my $f = $lines[$ln++];
 
 				next if ($f =~ /^-/);
-				last if (!$file && $f =~ /^\@\@/);
+				last if (!$file && $f =~ /^(?:\@\@|diff )/);
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
-					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
-					$length = -1;
+				$herecfg .= $rawlines[$ln - 1] . "\n";
+				if ($f =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+					$needs_help = 1;
+					next;
+				}
+				if ($f =~ /^\+\s*help\s*$/) {
+					$has_help = 1;
+					next;
 				}
 
-				$f =~ s/^.//;
-				$f =~ s/#.*//;
-				$f =~ s/^\s+//;
-				next if ($f =~ /^$/);
+				$f =~ s/^.//;	# strip patch context [+ ]
+				$f =~ s/#.*//;	# strip # directives
+				$f =~ s/^\s+//;	# strip leading blanks
+				next if ($f =~ /^$/);	# skip blank lines
 
+				# At the end of this Kconfig block:
 				# This only checks context lines in the patch
 				# and so hopefully shouldn't trigger false
 				# positives, even though some of these are
 				# common words in help texts
-				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
-						  if|endif|menu|endmenu|source)\b/x) {
-					$is_end = 1;
+				if ($f =~ /^(?:config|menuconfig|choice|endchoice|
+					       if|endif|menu|endmenu|source)\b/x) {
+					$herecfg =~ s/.*\n\Z//;	# strip last line
 					last;
 				}
-				$length++;
+				$length++ if ($has_help);
 			}
-			if ($is_start && $is_end && $length < $min_conf_desc_length) {
+			if ($needs_help &&
+			    (!$has_help ||
+			     ($has_help && $length < $min_conf_desc_length))) {
 				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+				     "please write a help paragraph that fully describes the config symbol\n" . $herecfg);
 			}
-			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
 
 # check MAINTAINERS entries


